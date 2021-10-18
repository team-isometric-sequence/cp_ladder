defmodule CpLadderWeb.PageController do
  use CpLadderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
