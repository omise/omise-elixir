defmodule Omise.Occurrence do
  @moduledoc ~S"""
  Provides Occurrence API interfaces.

  https://www.omise.co/occurrences-api
  """

  import Omise.HTTP

  defstruct [
    object:        "occurrence",
    id:            nil,
    livemode:      nil,
    location:      nil,
    schedule:      nil,
    schedule_date: nil,
    retry_date:    nil,
    processed_at:  nil,
    status:        nil,
    message:       nil,
    result:        nil,
    created:       nil,
  ]

  @type t :: %__MODULE__{
    object:        String.t,
    id:            String.t,
    livemode:      boolean,
    location:      String.t,
    schedule:      String.t,
    schedule_date: String.t,
    retry_date:    String.t,
    processed_at:  String.t,
    status:        String.t,
    message:       String.t,
    result:        String.t,
    created:       String.t,
  }

  @endpoint "occurrences"

  @doc ~S"""
  Retrieve an occurrence.

  ## Examples

      Omise.Occurrence.retrieve("occu_test_584yqgivyi2p1g828pl")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{id}", [], opts)
  end
end
