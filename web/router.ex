defmodule ShotLog.Router do
  use ShotLog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShotLog do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/brands", BrandController
    resources "/cameras", CameraController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShotLog do
  #   pipe_through :api
  # end
end
