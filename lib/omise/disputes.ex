defmodule Omise.Disputes do
  @moduledoc """
  An API for working with Disputes at Omise.
  """

  @endpoint "disputes"

  @doc """
  List all disputes.

  ## Examples

  ```
    {:ok, all_disputes}     = Omise.Disputes.list
    {:ok, open_disputes}    = Omise.Disputes.list(status: "open")
    {:ok, pending_disputes} = Omise.Disputes.list(status: "pending")
    {:ok, closed_isputes}   = Omise.Disputes.list(status: "closed")
  ```

  """
  def list(params \\ []) do
    status = params[:status] || ""
    Omise.make_request({:get, "#{@endpoint}/#{status}"})
  end

  @doc """
  Retrieve a dispute.

  ## Examples

  ```
    {:ok, dispute} = Omise.Disputes.retrieve("dspt_test_51yfnnpsxajeybpytm4")
  ```

  """
  def retrieve(id) do
    Omise.make_request({:get, "#{@endpoint}/#{id}"})
  end

  @doc """
  Update a dispute.

  ## Examples

  ```
    {:ok, dispute} = Omise.Disputes.update("dspt_test_4zgf15h89w8t775kcm8", message: "Hello, it's me")
  ```

  """
  def update(id, params) do
    Omise.make_request({:patch, "#{@endpoint}/#{id}", params})
  end
end
