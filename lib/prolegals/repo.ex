defmodule Prolegals.Repo do
  use Ecto.Repo,
    otp_app: :prolegals,
    adapter: Ecto.Adapters.Postgres
end
