defmodule ExBenchRunner.Pipeline do
  # We use Plug.Builder to have access to the plug/2 macro.
  # This macro can receive a function or a module plug and an
  # optional parameter that will be passed unchanged to the
  # given plug.
  use Plug.Builder
  plug(Plug.Logger)
  plug(ExBenchRunner.Metrics.PlugExporter, %{})
  plug(ExBenchRunner.Plug.Root, %{})
end
