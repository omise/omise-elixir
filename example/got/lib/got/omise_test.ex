defmodule GOT.OmiseTest do
  def create_charge(card: "xxxx", amount: _, description: _) do
    {:error, %Omise.Error{code: "failed_processing", message: "failed processing"}}
  end
  def create_charge(_) do
    {:ok, %Omise.Charge{paid: true}}
  end
end
