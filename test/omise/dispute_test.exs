defmodule Omise.DisputeTest do
  use Omise.TestCase

  it "can list all disputes", via: "disputes-get" do
    {:ok, list} = Omise.Dispute.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "dispute"))
  end

  it "can retrieve the dispute", via: "disputes/dspt_test_5089off452g5m5te7xs-get" do
    {:ok, dispute} = Omise.Dispute.retrieve("dspt_test_5089off452g5m5te7xs")

    assert dispute.object == "dispute"
    assert dispute.id == "dspt_test_5089off452g5m5te7xs"
  end

  it "can update the dispute", via: "disputes/dspt_test_5089off452g5m5te7xs-patch" do
    {:ok, dispute} = Omise.Dispute.update("dspt_test_5089off452g5m5te7xs", message: "New message")

    assert dispute.object == "dispute"
    assert dispute.message == "New message"
  end

  it "can search for disputes", via: "search-dispute-get" do
    {:ok, search} = Omise.Dispute.search(filters: [status: "open"])

    assert search.object == "search"
    assert search.scope == "dispute"
    assert search.query == ""
    assert search.filters == %{"status" => "open"}
    assert is_list(search.data)
  end

  it "can list all documents", via: "disputes/dspt_test_5089off452g5m5te7xs/documents-get" do
    {:ok, list} = Omise.Dispute.list_documents("dspt_test_5089off452g5m5te7xs")

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "document"))
  end

  it "can retrieve a document", via: "disputes/dspt_test_5089off452g5m5te7xs/documents/docu_test_55alihcdq6r2upo9slb-get" do
    {:ok, document} = Omise.Dispute.retrieve_document("dspt_test_5089off452g5m5te7xs", "docu_test_55alihcdq6r2upo9slb")

    assert document.object == "document"
    assert document.id == "docu_test_55alihcdq6r2upo9slb"
  end

  it "can upload a document", via: "disputes/dspt_test_5089off452g5m5te7xs/documents-post" do
    {:ok, document} = Omise.Dispute.upload_document("dspt_test_5089off452g5m5te7xs", file: "screenshot.png")

    assert document.object == "document"
    assert document.filename == "screenshot.png"
  end

  it "can destroy the document", via: "disputes/dspt_test_5089off452g5m5te7xs/documents/docu_test_55alihcdq6r2upo9slb-delete" do
    {:ok, document} = Omise.Dispute.destroy_document("dspt_test_5089off452g5m5te7xs", "docu_test_55alihcdq6r2upo9slb")

    assert document.object == "document"
    assert document.deleted
  end
end
