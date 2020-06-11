defmodule ProlegalsWeb.Router do
  use ProlegalsWeb, :router

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

  scope "/", ProlegalsWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", ProlegalsWeb do
    pipe_through :browser

    get "/", WebController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ProlegalsWeb do
  #   pipe_through :api
  # end
end
