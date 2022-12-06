defmodule JokeOMatic.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      JokeOMaticWeb.Telemetry,
      # Start the Ecto repository
      JokeOMatic.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: JokeOMatic.PubSub},
      # Start Finch
      {Finch, name: JokeOMatic.Finch},
      # Start the Endpoint (http/https)
      JokeOMaticWeb.Endpoint
      # Start a worker by calling: JokeOMatic.Worker.start_link(arg)
      # {JokeOMatic.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JokeOMatic.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JokeOMaticWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
