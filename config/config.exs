# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :prolegals,
  ecto_repos: [Prolegals.Repo]

# Configures the endpoint
config :prolegals, ProlegalsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BjM6HaVmnxqDA/xZ16xWvFy7xpE8jLIyouavZ+zQSmY3t1eoRfbUCdxyBZ28G3v1",
  render_errors: [view: ProlegalsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Prolegals.PubSub, adapter: Phoenix.PubSub.PG2]


# ------------------------Email Config -------------------------------#
config :Prolegals, Prolegals.Emails.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.gmail.com",
  port: 587,
  # or {:system, "SMTP_USERNAME"}
  username: "johnmfula360@gmail.com",
  # or {:system, "SMTP_PASSWORD"}
  password: "john@360",
  # can be `:always` or `:never`
  tls: :if_available,
  allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"],
  # can be `true`
  ssl: false,
  retries: 2


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
