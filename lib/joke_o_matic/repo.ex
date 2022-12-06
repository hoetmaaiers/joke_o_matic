defmodule JokeOMatic.Repo do
  use Ecto.Repo,
    otp_app: :joke_o_matic,
    adapter: Ecto.Adapters.Postgres
end
