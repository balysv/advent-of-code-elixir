defmodule AdventOfCode.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :inets, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, "~> 1.0"},
      {:statistics, "~> 0.6.2"},
      {:pelemay_fp, "~> 0.1.2"},
      {:memoize, "~> 1.4"},
      {:jason, "~> 1.2"},
      {:libgraph, git: "https://github.com/bitwalker/libgraph", branch: "main"},
      {:ssl_verify_fun, "~> 1.1.7", manager: :rebar3, override: true}
    ]
  end
end
