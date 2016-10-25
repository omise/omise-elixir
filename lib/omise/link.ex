defmodule Omise.Link do
  @moduledoc """
  Provides Link API interfaces.
  """

  defstruct [
    object:      "link",
    id:          nil,
    livemode:    nil,
    location:    nil,
    amount:      nil,
    currency:    nil,
    used:        nil,
    multiple:    nil,
    title:       nil,
    description: nil,
    charges:     %Omise.List{data: [%Omise.Charge{}]},
    payment_uri: nil,
    created:     nil
  ]

  @type t :: %__MODULE__{
    object:      String.t,
    id:          String.t,
    livemode:    boolean,
    location:    String.t,
    amount:      integer,
    currency:    String.t,
    used:        boolean,
    multiple:    boolean,
    title:       String.t,
    description: String.t,
    charges:     Omise.List.t,
    payment_uri: String.t,
    created:     String.t
  }

  @endpoint "links"

  @doc """
  List all links.

  Returns `{:ok, links}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Link.list

      Omise.Link.list(limit: 10, order: "reverse_chronological")

  """
  @spec list(Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ []) do
    Omise.HTTP.make_request(:get, @endpoint, params: params, as: %Omise.List{data: [%__MODULE__{}]})
  end

  @doc """
  Retrieve a link.

  ## Examples

      Omise.Link.retrieve("link_test_55s7oubg54yln9ey2h4")

  """
  @spec retrieve(String.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id) do
    Omise.HTTP.make_request(:get, "#{@endpoint}/#{id}", as: %__MODULE__{})
  end

  @doc """
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
  @spec create(Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def create(params \\ []) do
    Omise.HTTP.make_request(:post, @endpoint, body: {:form, params}, as: %__MODULE__{})
  end
end
