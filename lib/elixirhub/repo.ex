defmodule Elixirhub.Repo do
  use Ecto.Repo,
    otp_app: :elixirhub,
    adapter: Ecto.Adapters.Postgres
end
