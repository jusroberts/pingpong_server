defmodule PingpongServer.Router do
  use PingpongServer.Web, :router

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

  scope "/", PingpongServer do
    pipe_through :browser # Use the default browser stack

    get "/", RoomController, :index
    resources "/rooms", RoomController
  end

  # Other scopes may use custom stacks.
  scope "/api", PingpongServer do
    pipe_through :api

    get "rooms/:id/team/:team/increment", RoomController, :increment
  end
end
