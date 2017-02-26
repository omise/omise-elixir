defmodule Omise.TransactionTest do
  use ExUnit.Case
  import TestHelper

  @transaction_id "trxn_test_4yq7duwb9jts1vxgqua"

  test "list all transactions" do
    with_mock_request "transactions-get", fn ->
      {:ok, list} = Omise.Transaction.list

      assert %Omise.List{data: transactions} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each transactions, fn(transaction) ->
        assert %Omise.Transaction{} = transaction
        assert transaction.object == "transaction"
      end
    end
  end

  test "retrieve a transaction" do
    with_mock_request "transactions/#{@transaction_id}-get", fn ->
      {:ok, transaction} = Omise.Transaction.retrieve(@transaction_id)

      assert %Omise.Transaction{} = transaction
      assert transaction.object == "transaction"
      assert transaction.location
      assert transaction.amount
      assert transaction.type
      assert transaction.currency
      assert transaction.transferable
      assert transaction.created
    end
  end
end
