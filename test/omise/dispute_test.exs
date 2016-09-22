defmodule Omise.DisputeTest do
  use ExUnit.Case
  import TestHelper

  @dispute_id "dspt_test_5089off452g5m5te7xs"
  @document_id "docu_test_55alihcdq6r2upo9slb"

  test "list all disputes" do
    with_mock_request "disputes-get", fn ->
      {:ok, list} = Omise.Dispute.list

      assert %Omise.List{data: disputes} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each disputes, fn(dispute) ->
        assert %Omise.Dispute{} = dispute
        assert dispute.object == "dispute"
      end
    end
  end

  test "retrieve a dispute" do
    with_mock_request "disputes/#{@dispute_id}-get", fn ->
      {:ok, dispute} = Omise.Dispute.retrieve(@dispute_id)

      assert %Omise.Dispute{} = dispute
      assert dispute.object == "dispute"
      assert dispute.id
      assert is_boolean(dispute.livemode)
      assert dispute.location
      assert dispute.amount
      assert dispute.currency
      assert dispute.status
      refute dispute.message
      assert dispute.charge
      assert dispute.created
    end
  end

  test "update a dispute" do
    with_mock_request "disputes/#{@dispute_id}-patch", fn ->
      message = "Take me to your best friend house"
      {:ok, dispute} = Omise.Dispute.update(@dispute_id, message: message)

      assert %Omise.Dispute{} = dispute
      assert dispute.object == "dispute"
      assert dispute.message == message
    end
  end

  test "search disputes" do
    with_mock_request "search-dispute-get", fn ->
      {:ok, search_data} = Omise.Dispute.search(filters: [status: "open"])

      assert %Omise.Search{data: data} = search_data
      assert search_data.object == "search"
      assert search_data.scope == "dispute"
      assert search_data.query == ""
      assert search_data.filters == %{"status" => "open"}
      assert search_data.page == 1
      assert search_data.total_pages == 1
      assert search_data.total == 2
      assert is_list(data)
      Enum.each data, fn(dispute) ->
        assert dispute.status == "open"
      end
    end
  end

  test "list all documents" do
    with_mock_request "disputes/#{@dispute_id}/documents-get", fn ->
      {:ok, list} = Omise.Dispute.list_documents(@dispute_id)

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
      {:ok, document} = Omise.Dispute.retrieve_document(@dispute_id, @document_id)

      assert %Omise.Document{} = document
      assert document.object == "document"
      assert document.id
      refute document.livemode
      assert document.filename
    end
  end

  test "upload a document" do
    with_mock_request "disputes/#{@dispute_id}/documents-post", fn ->
      {:ok, document} = Omise.Dispute.upload_document(@dispute_id, file: "screenshot.png")

      assert %Omise.Document{} = document
      assert document.object == "document"
      assert document.id
      refute document.livemode
      assert document.filename
    end
  end

  test "destroy a document" do
    with_mock_request "disputes/#{@dispute_id}/documents-delete", fn ->
      {:ok, document} = Omise.Dispute.destroy_document(@dispute_id, @document_id)

      assert %Omise.Document{} = document
      assert document.object == "document"
      assert document.deleted
    end
  end
end
