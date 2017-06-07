defmodule Omise.Version do
  @moduledoc false

  def project_version do
    "0.5.1"
  end

  def api_version do
    Application.get_env(:omise, :api_version)
  end

  def elixir_version do
    System.version
  end
end
