defmodule Omise.Mixfile do
  use Mix.Project

  @version "0.4.1"

  def project do
    [
      app:             :omise,
      version:         @version,
      elixir:          "~> 1.2",
      description:     description(),
      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps:            deps(),
      package:         package(),
      docs:            [extras: ["README.md"]]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.9"},
      {:poison, "~> 2.2 or ~> 3.0"},

      # Dev dependencies
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.13", only: :dev},

      # Test dependencies
      {:mock, "~> 0.2", only: :test},

      # Dev & Test dependencies
      {:credo, "~> 0.6", only: [:dev, :test]}
    ]
  end

  defp description do
    "Omise client library for Elixir."
  end

  defp package do
    [
      files:       ~w(lib mix.exs README.md),
      maintainers: ["Teerawat Lamanchart"],
      licenses:    ["MIT"],
      links:       %{"GitHub" => "https://github.com/omise/omise-elixir"}
    ]
  end
end
