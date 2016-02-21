defmodule PingpongServer.PageController do
  use PingpongServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
