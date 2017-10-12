defmodule Omise.Link do
  @moduledoc ~S"""
  Provides Link API interfaces.

  <https://www.omise.co/links-api>
  """

  use Omise.HTTPClient, endpoint: "links"

  @doc ~S"""
  List all links.

  Returns `{:ok, links}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Link.list

      Omise.Link.list(limit: 10, order: "reverse_chronological")

  """
  @spec list(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def list(params \\ [], options \\ []) do
    get(@endpoint, params, options)
  end

  @doc ~S"""
  Retrieve a link.

  ## Examples

      Omise.Link.retrieve("link_test_55s7oubg54yln9ey2h4")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve(id, options \\ []) do
    get("#{@endpoint}/#{id}", [], options)
  end

  @doc ~S"""
  Create a link.

  Returns `{:ok, link}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      # For one time use
      Omise.Link.create(
        amount: 1000_00,
        currency: "thb",
        title: "Awesome Elixir",
        description: "This book will teach you about Elixir Programming Language"
      )

      # For multiple time use
      Omise.Link.create(
        amount: 1000_00,
        currency: "thb",
        title: "Awesome Elixir",
        description: "This book will teach you about Elixir Programming Language"
        multiple: true
      )

  """
  @spec create(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def create(params \\ [], options \\ []) do
    post(@endpoint, params, options)
  end
end
