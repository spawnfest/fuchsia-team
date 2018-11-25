require IEx

defmodule EligitWeb.PageController do
  use EligitWeb, :controller

  def index(conn, params) do
    render(conn, "index.html")
  end

  def create(conn, %{ "repo" => %{ "url" => url }} = params) do
    render(conn, "report.html", url: url)
  end
end
