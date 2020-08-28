defmodule Prolegals.Repo do
  use Ecto.Repo,
    otp_app: :prolegals,
    #----------- Mysql
    # adapter: Ecto.Adapters.MySQL
    # adapter: Ecto.Adapters.MyXQL
    #----------- mssql
    adapter: Tds.Ecto
    #----------- Postgres
    # adapter: Ecto.Adapters.Postgres
    use Scrivener
end
