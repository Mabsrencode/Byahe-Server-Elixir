defmodule DriverUserCoordinates.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DriverUserCoordinatesWeb.Telemetry,
      DriverUserCoordinates.Repo,
      {DNSCluster, query: Application.get_env(:driver_user_coordinates, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DriverUserCoordinates.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DriverUserCoordinates.Finch},
      # Start a worker by calling: DriverUserCoordinates.Worker.start_link(arg)
      # {DriverUserCoordinates.Worker, arg},
      # Start to serve requests, typically the last entry
      DriverUserCoordinatesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DriverUserCoordinates.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DriverUserCoordinatesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
