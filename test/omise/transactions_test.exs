defmodule Omise.TransactionsTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "list all transactions" do
    with_mock_request "transactions_list", fn ->
      {:ok, transactions} = Omise.Transactions.list

      assert is_list(transactions[:data])
    end
  end

  test "retrieve a transaction" do
    with_mock_request "transaction_retrieve", fn ->
      {:ok, transaction} = Omise.Transactions.retrieve("trxn_test_52om9enzl8bqx3f2bf4")

      assert transaction.id == "trxn_test_52om9enzl8bqx3f2bf4"
      assert transaction.location
      assert transaction.amount
      assert transaction.type
      assert transaction.currency
      assert transaction.transferable
      assert transaction.created
    end
  end
end
