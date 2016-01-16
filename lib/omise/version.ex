defmodule Omise.Version do
  @moduledoc false

  def omise_version do
    "0.1.4"
  end

  def api_version do
    Application.get_env(:omise, :api_version)
  end

  def elixir_version do
    System.version
  end
end
