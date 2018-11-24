defmodule EligitWeb.PageController do
  use EligitWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
