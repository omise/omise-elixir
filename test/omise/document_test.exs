defmodule Omise.DocumentTest do
  use ExUnit.Case
  import TestHelper

  @dispute_id "dspt_test_5089off452g5m5te7xs"
  @document_id "docu_test_55alihcdq6r2upo9slb"

  test "list all documents" do
    with_mock_request "disputes/#{@dispute_id}/documents-get", fn ->
      {:ok, list} = Omise.Document.list("disputes/#{@dispute_id}")

      assert %Omise.List{data: documents} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each documents, fn(document) ->
        assert %Omise.Document{} = document
        assert document.object == "document"
      end
    end
  end

  test "retrieve a document" do
    with_mock_request "disputes/#{@dispute_id}/documents/#{@document_id}-get", fn ->
      {:ok, document} = Omise.Document.retrieve("disputes/#{@dispute_id}", @document_id)

      assert %Omise.Document{} = document
      assert document.object == "document"
      assert document.id
      refute document.livemode
      assert document.filename
    end
  end

  test "upload a document" do
    with_mock_request "disputes/#{@dispute_id}/documents-post", fn ->
      {:ok, document} = Omise.Document.create("disputes/#{@dispute_id}", file: "screenshot.png")

      assert %Omise.Document{} = document
      assert document.object == "document"
      assert document.id
      refute document.livemode
      assert document.filename
    end
  end

  test "destroy a document" do
    with_mock_request "disputes/#{@dispute_id}/documents-delete", fn ->
      {:ok, document} = Omise.Document.destroy("disputes/#{@dispute_id}", @document_id)

      assert %Omise.Document{} = document
      assert document.object == "document"
      assert document.deleted
    end
  end
end
