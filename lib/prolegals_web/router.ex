defmodule ProlegalsWeb.Router do
  use ProlegalsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(ProlegalsWeb.Plugs.SetUser)
    plug(ProlegalsWeb.Plugs.SessionTimeout, timeout_after_seconds: 3_600)
  end

  pipeline :session do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :app do
    plug(:put_layout, {ProlegalsWeb.LayoutView, :app})
  end

  pipeline :dashboard_layout do
    plug(:put_layout, {ProlegalsWeb.LayoutView, :dashboard_layout})
  end

  pipeline :no_layout do
    plug :put_layout, false
  end

  scope "/", ProlegalsWeb do
    pipe_through([:browser, :no_layout])
    get("/logout/current/user", SessionController, :signout)
  end

  scope "/", ProlegalsWeb do
    pipe_through([:browser, :app])
    # post("/new/password", UserController, :change_password)
    #
    get("/dashboard", UserController, :dashboard)
    # ---------------------------User Maintenance
    get "/User/Maintenance", UserController, :user_management
    post "/Create/User", UserController, :create_user

    # ---------------------------Legal Controller
    get "/Contacts", LegalController, :contacts
    post "/Create/Contact", LegalController, :create_contact
    get "/Manage/Cases", LegalController, :case_mgt
    post "/Add/New/Case", LegalController, :create_case
    get "/Notifications", LegalController, :notifications
    get "/Tasks", LegalController, :tasks

    # ////////////////////////////////////////////////////////////////// Security Controller
    get "/list/logbook/user", SecurityController, :list_log_book_users
    post "/create/logbook/user", SecurityController, :create_log_book_user
    post "/add/timeout", SecurityController, :add_time_out
    post "/logbook/update", SecurityController, :edit_log_book_user
    get "/view/logbook/user", SecurityController, :view_log_book_user

    # ---------------------------Firearms Inventory
    get "/firearms", AdminController, :firearm
    post "/Create/Firearm", AdminController, :create_firearms_inventory
    post "/update/Firearm", AdminController, :update_firearms_inventory
    get "/Delete/Firearm", AdminController, :delete_firearms_inventory
    get "/Firearms/View", AdminController, :view_firearm

    # ---------------------------Ammunition Inventory
    get "/Ammunition", AdminController, :ammunition
    post "/Create/Ammunition", AdminController, :create_ammunition_inventory
    post "/Update/Ammunition", AdminController, :update_ammunition_inventory
    get "/Delete/Ammunition", AdminController, :delete_ammunition_inventory

    # ---------------------------Legal Controller
    get "/Contacts", LegalController, :contacts
    post "/Create/Contact", LegalController, :create_contact
    get "/Manage/Cases", LegalController, :case_mgt
    post "/Add/New/Case", LegalController, :create_case
    get "/Notifications", LegalController, :notifications
    get "/Tasks", LegalController, :tasks

  end

  scope "/", ProlegalsWeb do
    pipe_through([:session, :app])
    # pipe_through :browser
    # get "/Dashboard", UserController, :dashboard
    get("/", SessionController, :new)
    post("/", SessionController, :create)
    get("/forgortFleetHub//password", UserController, :forgot_password)
    post("/confirmation/token", UserController, :token)
    get("/reset/FleetHub/password", UserController, :default_password)
  end

  scope "/", ProlegalsWeb do
    pipe_through([:session, :dashboard_layout])
    # ---------------------------Test
    get("/new/password", UserController, :new_password)
    post("/reset/password", UserController, :default_password)
    post("/reset/user/password", UserController, :reset_pwd)
    # ----------------------------------------------------------------
  end

  # Other scopes may use custom stacks.
  # scope "/api", ProlegalsWeb do
  #   pipe_through :api
  # end
end
