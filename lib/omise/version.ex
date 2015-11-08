defmodule Omise.Version do
  @doc false
  def omise_version do
    Mix.Project.config[:version]
  end

  @doc false
  def api_version do
    Application.get_env(:omise, :api_version)
  end

  @doc false
  def elixir_version do
    System.version
  end
end
