defmodule Omise.Mixfile do
  use Mix.Project

  def project do
    [
      app: :omise,
      version: "0.1.2",
      elixir: "~> 1.1",
      description: description,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      package: package
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :poison]]
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
      {:httpoison, "~> 0.7.4"},
      {:poison, "~> 1.5"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.10", only: :dev}
    ]
  end

  defp description do
    """
    Omise client library for Elixir.
    """
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md),
      maintainers: ["Teerawat Lamanchart"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/teerawat1992/omise"}
    ]
  end
end
