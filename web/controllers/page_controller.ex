defmodule ShotLog.PageController do
  use ShotLog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
