require IEx
require Gitstat

defmodule EligitWeb.PageController do
  use EligitWeb, :controller

  def index(conn, params) do
    render(conn, "index.html")
  end

  def create(conn, %{ "repo" => %{ "url" => url }} = params) do
    # First win!!! TODO: refactor all this shit! =D
    repo_local_path = "/tmp/eligit"
    File.rm_rf!(repo_local_path)
    File.mkdir!(repo_local_path)
    { clone_status, repo } = Git.clone [url, repo_local_path]

    { :ok, pid } = Gitstat.Fame.start_link()
    fame = Gitstat.Fame.run(pid, repo_local_path) |> Enum.reject &is_nil/1

    render(conn, "report.html",
      url: url,
      clone_status: clone_status,
      repo: repo,
      fame: fame
    )
  end
end
