defmodule WebrtcTutorial.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {WebrtcTutorial.Room, []},
      # Start the Telemetry supervisor
      WebrtcTutorialWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: WebrtcTutorial.PubSub},
      # Start the Endpoint (http/https)
      WebrtcTutorialWeb.Endpoint
      # Start a worker by calling: WebrtcTutorial.Worker.start_link(arg)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebrtcTutorial.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebrtcTutorialWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
