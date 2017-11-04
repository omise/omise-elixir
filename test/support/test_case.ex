defmodule Omise.TestCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

      import Omise.TestCase
    end
  end

  setup_all do
    HTTPoison.start()
    ExVCR.Config.filter_request_options("basic_auth")

    Omise.configure(
      public_key: System.get_env("OMISE_PUBLIC_KEY") || "pkey_xxx",
      secret_key: System.get_env("OMISE_SECRET_KEY") || "skey_xxx"
    )

    :ok
  end

  def set_fixture_dir(name) do
    ExVCR.Config.cassette_library_dir("test/fixture/#{name}")
  end
end
