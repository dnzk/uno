defmodule Uno.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      UnoWeb.Telemetry,
      # Start the Ecto repository
      Uno.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Uno.PubSub},
      # Start Finch
      {Finch, name: Uno.Finch},
      # Start the Endpoint (http/https)
      UnoWeb.Endpoint
      # Start a worker by calling: Uno.Worker.start_link(arg)
      # {Uno.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Uno.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UnoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
