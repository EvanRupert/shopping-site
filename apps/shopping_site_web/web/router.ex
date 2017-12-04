# TODO: improve search to also search description
# TODO: add tokanization to search to search words individually

# TODO: add someway to remove cookies after a certain amount of time

# TODO: implement file validation for Arc uploading

# TODO: implement item removal feature
# FIXME: fix the admin price field to accept floating point

defmodule ShoppingSiteWeb.Router do
  use ShoppingSiteWeb.Web, :router

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

  scope "/", ShoppingSiteWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/items", ItemController, :list
    post "/search", ItemController, :search

    get "/admin", AdminController, :admin
    post "/create", AdminController, :create
    post "/remove", AdminController, :remove

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete

  end


  # Other scopes may use custom stacks.
  # scope "/api", ShoppingSiteWeb do
  #   pipe_through :api
  # end
end
