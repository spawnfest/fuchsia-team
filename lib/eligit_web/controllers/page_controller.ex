require IEx
require Gitstat

defmodule EligitWeb.PageController do
  use EligitWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  # def create(conn, %{ "repo" => %{ "url" => url }} = params) do
  #   # First win!!! TODO: refactor all this shit! =D
  #   random_string = :crypto.strong_rand_bytes(12) |> Base.url_encode64 |> binary_part(0, 12)
  #   repo_local_path = "/tmp/#{random_string}"
  #   File.rm_rf!(repo_local_path)
  #   File.mkdir!(repo_local_path)
  #   { clone_status, repo } = Git.clone [url, repo_local_path]

  #   { :ok, pid } = Gitstat.Fame.start_link()
  #   fame = Gitstat.Fame.run(pid, repo_local_path) |> Enum.reject &is_nil/1
  #   File.rm_rf!(repo_local_path)
  #   render(conn, "report.html",
  #     url: url,
  #     clone_status: clone_status,
  #     repo: repo,
  #     fame: fame
  #   )
  # end

  def async_create(conn, %{ "repo" => %{ "url" => url }}) do
    random_string = :crypto.strong_rand_bytes(12) |> Base.url_encode64 |> binary_part(0, 12)
    repo_local_path = "/tmp/#{random_string}"
    File.rm_rf!(repo_local_path)
    File.mkdir!(repo_local_path)
    Git.clone [url, "--depth=1", repo_local_path]


    { :ok, pid } = Gitstat.Cake.start_link()
    Gitstat.Cake.async_run(pid, self(), repo_local_path)

    broadcast_cakes()

    File.rm_rf!(repo_local_path)

    text conn, "console.log('OMG')"
  end

  defp broadcast_cakes do
    receive do
      {:partial, payload} ->
         EligitWeb.Endpoint.broadcast!("room:lobby", "cake", %{ result: payload })
         broadcast_cakes()
      {:total, payload} ->
         EligitWeb.Endpoint.broadcast!("room:lobby", "cake", %{ result: payload })
    end
  end
end
