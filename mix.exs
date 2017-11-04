defmodule Omise.Mixfile do
  use Mix.Project

  @version "0.6.0"

  def project do
    [
      app: :omise,
      version: @version,
      elixir: "~> 1.4",
      description: description(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: [extras: ["README.md"]],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.9"},
      {:poison, "~> 2.2 or ~> 3.0"},

      # Dev dependencies
      {:ex_doc, "~> 0.13", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},

      # Test dependencies
      {:excoveralls, "~> 0.6", only: :test},
      {:exvcr, "~> 0.9.0", only: :test}
    ]
  end

  defp description do
    "Omise client library for Elixir."
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md),
      maintainers: ["Teerawat Lamanchart"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/omise/omise-elixir"}
    ]
  end
end
