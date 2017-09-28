# TODO: Add search bar
# TODO: Attempt to enable hot reloading for search function

# TODO: improve search to also search description
# TODO: add tokanization to search to search words individually


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
  end


  # Other scopes may use custom stacks.
  # scope "/api", ShoppingSiteWeb do
  #   pipe_through :api
  # end
end
