defmodule GOT.OmiseTest do
  def create_charge(_) do
    {:ok, %Omise.Charge{paid: true}}
  end
end
