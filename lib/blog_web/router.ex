defmodule BlogWeb.Router do
  use BlogWeb, :router

  alias BlogWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plugs.SetCurrentUser
  end

  pipeline :protected do
    plug :put_layout, {BlogWeb.LayoutView, :protected}
    plug Plugs.EnsureAuthenticated
  end

  pipeline :feed do
    plug :accepts, ["xml"]
  end

  scope "/", BlogWeb do
    pipe_through [:browser]

    get "/", PortfolioController, :index

    get "/blog", BlogController, :index
    get "/blog/:titled_slug", BlogController, :show, as: :post

    get "/tags/:slug", TagController, :index

    get "/courses", CourseController, :index

    resources "/in", SessionController, only: [:new, :create], as: :sign_in
    delete "/out", SessionController, :delete, as: :sign_out
  end

  scope "/admin", BlogWeb.Admin, as: :admin do
    pipe_through [:browser, :protected]

    get "/", DashboardController, :index

    resources "/posts", PostController, param: "titled_slug"
    resources "/tags", TagController, param: "slug"
    resources "/users", UserController
  end
end
