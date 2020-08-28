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
    get "/Account/Disabled", SessionController, :error_405
  end

  scope "/", ProlegalsWeb do
    pipe_through([:browser, :app])
    # post("/new/password", UserController, :change_password)
    #
    get("/dashboard", UserController, :dashboard)
    # ---------------------------User Maintenance
    get "/User/Maintenance", UserController, :user_management
    post "/Create/User", UserController, :create_user
    get "/View/User/Maintenance", UserController, :view_mgt_user
    get "/User/Activity/Logs", UserController, :user_logs

    # ---------------------- Deactivated ---------------------------
    post "/Deactivate/Account", UserController, :deactivate_account
    
     # --------------------- On Leave --------------------------------
     get "/Users/On/Leave", UserController, :users_on_leave
     post "/Activate/Leave/Account", UserController, :activate_user_on_leave

     # -----------------------Dismissed---------------------------------
    get "/Dismissed/User/Accounts", UserController, :dismissed_users
    post "/Activate/dismissed/Account", UserController, :activate_dismissed_user


    # ---------------------- Suspension ---------------------------
    get "/Suspended/Users", UserController, :suspended_users
    post "/Activate/Suspended/Account", UserController, :activate_suspended_user

    # ------------------------Retired -------------------------------
    get "/Retired/User/Accounts", UserController, :retired_users
    post "/Activate/retired/Account", UserController, :activate_retired_user

    # ---------------------------------------------------LEGAL CONTROLLER
    # ------------------------------ Case_Mgt
    get "/Manage/Cases", LegalController, :case_mgt
    post "/Add/New/Case", LegalController, :create_case
    post "/Update/Case/Details", LegalController, :edit_case
    get "/Case/Updates", LegalController, :case_update
    post "/New/Evidence", LegalController, :evidence_update
    get "/Notifications", LegalController, :notifications
    post "/create/Email", LegalController, :create_email
    get "/View/Case/History", LegalController, :view_case_history

    # ------------------------------ Task_Mgt
    get "/Tasks", LegalController, :tasks
    post "/Create/Event", LegalController, :create_task
    get "/Types/of/Cases", LegalController, :practice_area
    post "/Create/Case/Type", LegalController, :create_case_type
    post "/Update/Case/Type", LegalController, :update_case_type
    get "/Business/Category", LegalController, :bus_category
    post "/Create/Business/Category", LegalController, :create_business_type
    post "/Update/Business/Category", LegalController, :update_business_type

    # ---------------------------Contact_Mgt
    get "/Contacts", LegalController, :contacts
    post "/Create/Contact", LegalController, :create_contact
    post "/Update/Contact", LegalController, :update_contact
    delete "/Delete/Contact", LegalController, :delete_contact
    post "/Retore/Contact", LegalController, :restore
    post "/Create/Bulk/Contacts", LegalController, :create_bulk_contact
    get "/Delete/Contact/Forever", LegalController, :delete_forever
    get "/Deleted/Contacts", LegalController, :contacts_trash
    post "/Enable/Client/Portal", LegalController, :enable_client_portal
    post "/Disable/Client/Portal", LegalController, :disable_client_portal

    # ---------------------------Report_Mgt
    get "/Litigation/Reports", LegalController, :li_reports
    get "/Case/Reports", LegalController, :case_reports



    # ---------------------------------------------------SECURITY CONTROLLER
    # ----------------------------Security Controller
    get "/list/logbook/user", SecurityController, :list_log_book_users
    post "/create/logbook/user", SecurityController, :create_log_book_user
    post "/add/timeout", SecurityController, :add_time_out
    get "/add/timeout", SecurityController, :add_time_out
    post "/logbook/update", SecurityController, :edit_log_book_user
    get "/view/logbook/user", SecurityController, :view_log_book_user
    get "/history/logbook/user", SecurityController, :history_log_book_users
    get "/check_in/visitor", SecurityController, :recheck_in_visitor
    post "/check/in/user", SecurityController, :recheck_in
    # -------------------Security Reports------------------------------------
    get "/security/report", SecurityController, :sec_reports
    post "/security/report", SecurityController, :item_lookup
    get "/download/csv", SecurityController, :csv_exp 
    get "/view/sec_report/details", SecurityController, :view_report_details

    # ----------------------------------------------------------------------
    

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
    get "/Ammunition/View", AdminController, :view_ammunition

    # --------------------------------------------- System_Directory CONTROLLER
    get "System/Directory", SystemDirectoryController, :index
    post "System/Directory", SystemDirectoryController, :create
    post "/add/logbook/user", SecurityController, :add_log_book_user

    # ---------------------------Inventory
    get "/Inventory", AdminController, :inventory
    post "/Create/Category", AdminController, :create_inventory
    post "/Update/Category", AdminController, :update_inventory
    get "/Delete/Category", AdminController, :delete_inventory
    

     # ---------------------------Assets
     get "/Asset", AdminController, :asset
     post "/Create/Asset", AdminController, :create_asset
     get "/Assets/View_Asset", AdminController, :view_asset
     post "/Update/Asset", AdminController, :update_asset
     post "/Edit/Asset", AdminController, :edit_asset
     get "/Delete/Asset", AdminController, :delete_asset

    # ---------------------------Location
    get "/Location", AdminController, :location
    post "/Create/Location", AdminController, :create_location
    post "/Edit/Location", AdminController, :edit_location

    # ---------------------------Location
    get "/Employees", AdminController, :employee
    post "/Create/Employee", AdminController, :create_employee
    post "/Edit/Employee", AdminController, :edit_employee
    post "/Create/Bulk/Employee", AdminController, :handle_bulk_upload

     # ---------------------------Assets
     get "/Vendor", AdminController, :vendor
     post "/Create/Vendor", AdminController, :create_vendor
     post "/Edit/Vendor", AdminController, :edit_vendor

    # ---------------------------Legal Controller
    get "/Contacts", LegalController, :contacts
    post "/Create/Contact", LegalController, :create_contact
    post "/update/Contact", LegalController, :update_contact
    post "/delete/Contact", LegalController, :delete_contact
    get "/Manage/Cases", LegalController, :case_mgt
    post "/Add/New/Case", LegalController, :create_case
    get "/Notifications", LegalController, :notifications
    get "/Tasks", LegalController, :tasks


    # -------------------------------------------------- Client Controller
    get "/messages", ClientController, :list_messages
    get "/document", ClientController, :list_document
    post "/create/messages", ClientController, :create_message
    post "/bulk/upload", ClientController, :document_upload
    get "/trash", ClientController, :trash
    get "/sent/message", ClientController, :sent_message
    get "/move/trash", ClientController, :update_trash
    post "/move/trash", ClientController, :update_trash
    get "/move/trash_to/inbox", ClientController, :trash_to_inbox
    post "/move/trash_to/inbox", ClientController, :trash_to_inbox
    

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
