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
    get "/User/Activity/Logs", UserController, :user_logs

    # ---------------------------Legal Controller
    get "/Contacts", LegalController, :contacts
    post "/Create/Contact", LegalController, :create_contact
    get "/Manage/Cases", LegalController, :case_mgt
    post "/Add/New/Case", LegalController, :create_case
    get "/Notifications", LegalController, :notifications
    get "/Tasks", LegalController, :tasks
    post "/Create/Event", LegalController, :create_task
    get "/Types/of/Cases", LegalController, :practice_area
    post "/Create/Case/Type", LegalController, :create_case_type
    post "/Update/Case/Type", LegalController, :update_case_type
    get "/Business/Category", LegalController, :bus_category
    post "/Create/Business/Category", LegalController, :create_business_type
    post "/Update/Business/Category", LegalController, :update_business_type

    # ////////////////////////////////////////////////////////////////// Security Controller
    get "/list/logbook/user", SecurityController, :list_log_book_users
    post "/create/logbook/user", SecurityController, :create_log_book_user
    post "/add/timeout", SecurityController, :add_time_out
    post "/logbook/update", SecurityController, :edit_log_book_user
    get "/view/logbook/user", SecurityController, :view_log_book_user
    post "/add/logbook/user", SecurityController, :add_log_book_user

    # ---------------------------Inventory
    get "/Inventory", AdminController, :inventory
    post "/Create/Category", AdminController, :create_inventory
    post "/Update/Category", AdminController, :update_inventory
    get "/Delete/Category", AdminController, :delete_inventory
    get "/Assets", AdminController, :view_assets

     # ---------------------------Assets
     get "/Asset", AdminController, :asset
     post "/Create/Asset", AdminController, :create_asset
     get "/Assets/View_Asset", AdminController, :view_asset
     post "/Update/Asset", AdminController, :update_asset
     get "/Delete/Asset", AdminController, :delete_asset

    # ---------------------------Legal Controller
    get "/Contacts", LegalController, :contacts
    post "/Create/Contact", LegalController, :create_contact
    post "/update/Contact", LegalController, :update_contact
    post "/delete/Contact", LegalController, :delete_contact
    get "/Manage/Cases", LegalController, :case_mgt
    post "/Add/New/Case", LegalController, :create_case
    get "/Notifications", LegalController, :notifications
    get "/Tasks", LegalController, :tasks

    # ////////////////////////////////////////////////////////////////// Client Controller
    get "/messages", ClientController, :list_messages
    post "/create/messages", ClientController, :create_message

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
