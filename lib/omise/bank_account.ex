defmodule Omise.BankAccount do
  @moduledoc """
  Omise Bank Account Object.

  https://www.omise.co/bank-account-api
  """

  @type t :: Omise.ThaiBankAccount.t | Omise.JapaneseBankAccount.t

  @attributes [
    object:      "bank_account",
    last_digits: nil,
    name:        nil,
    created:     nil
  ]

  @doc false
  def attributes, do: @attributes

  @doc false
  def check_type(%{"brand" => _}) do
    Omise.ThaiBankAccount
  end
  def check_type(%{"bank_code" => _, "branch_code" => _, "account_type" => _}) do
    Omise.JapaneseBankAccount
  end

  defimpl Poison.Decoder, for: [Omise.Recipient, Omise.Transfer] do
    def decode(%{bank_account: nil} = object, _) do
      object
    end
    def decode(%{bank_account: bank_account} = object, _) do
      bank_account_attributes =
        bank_account
        |> Enum.map(fn({k,v}) -> {String.to_atom(k), v} end)
        |> Enum.into(%{})

      %{object | bank_account: struct(Omise.BankAccount.check_type(bank_account), bank_account_attributes)}
    end
    def decode(object, _) do
      object
    end
  end
end
