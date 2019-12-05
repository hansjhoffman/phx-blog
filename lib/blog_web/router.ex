defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug Plug.Authenticate, repo: Blog.Repo
  end

  pipeline :protected do
    plug :put_layout, {BlogWeb.LayoutView, :protected}
  end

  pipeline :feed do
    plug :accepts, ["xml"]
  end

  scope "/", BlogWeb do
    pipe_through [:browser]

    resources "/sessions", SessionController,
      only: [:new, :create, :delete],
      singleton: true
  end

  scope "/admin", BlogWeb.Admin, as: :admin do
    pipe_through [:browser, :protected]

    get "/", PageController, :index
    resources "/users", UserController
  end

  scope "/cms", BlogWeb.CMS, as: :cms do
    pipe_through [:browser, :protected]

    resources "/posts", PostController
    resources "/authors", AuthorController
    resources "/tags", TagController
  end
end
