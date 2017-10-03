defmodule Omise.ReceiptTest do
  use ExUnit.Case
  import TestHelper

  @receipt_id "rcpt_test_12345"

  test "list all receipts" do
    with_mock_request "receipts-get", fn ->
      {:ok, list} = Omise.Receipt.list

      assert %Omise.List{data: receipts} = list
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each receipts, fn(receipt) ->
        assert %Omise.Receipt{} = receipt
        assert receipt.object == "receipt"
      end
    end
  end

  test "retrieve a receipt" do
    with_mock_request "receipts/#{@receipt_id}-get", fn ->
      {:ok, receipt} = Omise.Receipt.retrieve(@receipt_id)

      assert %Omise.Receipt{} = receipt
      assert receipt.object == "receipt"
      assert receipt.id
      assert receipt.number
      assert receipt.location
      assert receipt.date
      assert receipt.customer_name
      assert receipt.customer_address
      assert receipt.customer_tax_id
      assert receipt.customer_email
      assert receipt.customer_statement_name
      assert receipt.company_name
      assert receipt.company_address
      assert receipt.company_tax_id
      assert receipt.charge_fee
      assert receipt.voided_fee
      assert receipt.transfer_fee
      assert receipt.subtotal
      assert receipt.vat
      assert receipt.wht
      assert receipt.total
      assert is_boolean(receipt.credit_note)
      assert receipt.currency
    end
  end
end
