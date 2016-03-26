defmodule GOT.OmiseTest do
  def create_charge(card: "xxxx", amount: _, description: _) do
    {:error, %Omise.Error{code: "used_token", message: "token was already used"}}
  end
  def create_charge(_) do
    {:ok, %Omise.Charge{paid: true}}
  end
end
