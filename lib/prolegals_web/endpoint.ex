defmodule ProlegalsWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :prolegals

  socket "/socket", ProlegalsWeb.UserSocket,
    websocket: true,
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :prolegals,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt webfonts),
    at: "/uploads",
    from: Path.expand('./uploads'),
    gzip: false

  plug Plug.Static, at: "/uploads", from: Path.expand('./uploads'), gzip: false

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_prolegals_key",
    signing_salt: "BMw2jyMl"

  plug ProlegalsWeb.Router
end
