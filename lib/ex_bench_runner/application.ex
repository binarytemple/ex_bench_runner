defmodule ExBenchRunner.Application do
  use Application
  require Logger
  @delay 1000

  def start(_type, _args) do
    ExBenchRunner.Metrics.PlugExporter.setup()
    Prometheus.Registry.register_collector(:prometheus_process_collector)

    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: ExBenchRunner.Pipeline,
        options: [port: 4000, transport_options: [num_acceptors: 5, max_connections: 5]]
      )
    ]

    opts = [strategy: :one_for_one, name: ExBenchRunner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def stop() do
    stop(nil)
  end

  def stop(_state) do
    Logger.debug("#{__MODULE__} terminating")
    Supervisor.stop(ExBenchRunner.Supervisor)
  end
end
