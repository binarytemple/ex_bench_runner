defmodule ExBenchRunner.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_bench_runner,
      version: "0.0.1",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      package: package(),
      application: application(),
      description: description(),
      deps: deps()
    ]
  end

  def application() do
    application(Mix.env())
  end

  def application(:test) do
    [
      extra_applications: [:logger]
    ]
  end

  def application(:dev) do
    [
      extra_applications: [:prometheus, :cowboy, :logger],
      mod: {ExBenchRunner.Application, [[], []]}
    ]
  end

  def application(:prod) do
    [
      extra_applications: [:prometheus, :cowboy, :logger],
      mod: {ExBenchRunner.Application, [[], []]}
    ]
  end

  defp deps do
    [
      {:ex_bench, "~> 0.3.0"},
      {:prometheus_plugs, "~> 1.1.5"},
      {:prometheus_process_collector, "~> 1.4"},
      {:plug_cowboy, "~> 2.1"}
    ]
  end

  defp package() do
    [
      files: ~w( lib mix.exs priv README.md LICENSE),
      homepage_url: "https://github.com/bryanhuntesl/ex_bench_runner",
      licenses: ["Apache 2"],
      links: %{"GitHub" => "https://github.com/bryanhuntesl/ex_bench_runner"},
      source_url: "https://github.com//bryanhuntesl/ex_bench_runner"
    ]
  end

  defp description() do
    "A runner for the ex_bench application - gives nice web stats etc"
  end
end
