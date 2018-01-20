defmodule Omise.DisputeTest do
  use Omise.TestCase

  alias Omise.Dispute

  setup_all do: set_fixture_dir("dispute")

  describe "list/2" do
    test "lists all disputes" do
      use_cassette "list_disputes" do
        assert Dispute.list(limit: 1) ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Dispute{
                        amount: 1_000_000,
                        charge: "chrg_test_557ib11djeat7p5k22r",
                        closed_at: nil,
                        created: "2016-09-10T10:18:21Z",
                        currency: "thb",
                        documents: %Omise.List{
                          data: [
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55am2tt3xave44l7vni",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55am2tt3xave44l7vni",
                              object: "document"
                            },
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55alzusch6dw7w81cf1",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55alzusch6dw7w81cf1",
                              object: "document"
                            },
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55alzscjq4pfhxfkk18",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55alzscjq4pfhxfkk18",
                              object: "document"
                            },
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55alzpo2x5r9mkedkng",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55alzpo2x5r9mkedkng",
                              object: "document"
                            },
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55alzjapkv99mbelg6q",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55alzjapkv99mbelg6q",
                              object: "document"
                            },
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55alwcu1phxmsxx3y9p",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55alwcu1phxmsxx3y9p",
                              object: "document"
                            }
                          ],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T11:59:20Z",
                          total: 6
                        },
                        id: "dspt_test_55aj9q9iipt3tcdwb5r",
                        livemode: false,
                        location: "/disputes/dspt_test_55aj9q9iipt3tcdwb5r",
                        message: nil,
                        object: "dispute",
                        reason_code: "goods_or_services_not_provided",
                        reason_message: "Services not provided or Merchandise not received",
                        status: "open",
                        transaction: "trxn_test_55aj9q9nyokxlvall1i"
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 1,
                    location: "/disputes",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T11:59:20Z",
                    total: 2
                  }}
      end
    end

    test "lists all open disputes" do
      use_cassette "list_open_disputes" do
        assert Dispute.list(status: "open", limit: 1) ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Dispute{
                        amount: 1_000_000,
                        charge: "chrg_test_557ib11djeat7p5k22r",
                        closed_at: nil,
                        created: "2016-09-10T10:18:21Z",
                        currency: "thb",
                        documents: %Omise.List{
                          data: [
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55am2tt3xave44l7vni",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55am2tt3xave44l7vni",
                              object: "document"
                            },
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55alzusch6dw7w81cf1",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55alzusch6dw7w81cf1",
                              object: "document"
                            },
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55alzscjq4pfhxfkk18",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55alzscjq4pfhxfkk18",
                              object: "document"
                            },
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55alzpo2x5r9mkedkng",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55alzpo2x5r9mkedkng",
                              object: "document"
                            },
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55alzjapkv99mbelg6q",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55alzjapkv99mbelg6q",
                              object: "document"
                            },
                            %Omise.Document{
                              deleted: false,
                              filename: "screenshot.png",
                              id: "docu_test_55alwcu1phxmsxx3y9p",
                              livemode: false,
                              location:
                                "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents/docu_test_55alwcu1phxmsxx3y9p",
                              object: "document"
                            }
                          ],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/disputes/dspt_test_55aj9q9iipt3tcdwb5r/documents",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T11:59:21Z",
                          total: 6
                        },
                        id: "dspt_test_55aj9q9iipt3tcdwb5r",
                        livemode: false,
                        location: "/disputes/dspt_test_55aj9q9iipt3tcdwb5r",
                        message: nil,
                        object: "dispute",
                        reason_code: "goods_or_services_not_provided",
                        reason_message: "Services not provided or Merchandise not received",
                        status: "open",
                        transaction: "trxn_test_55aj9q9nyokxlvall1i"
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 1,
                    location: "/disputes/open",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T11:59:21Z",
                    total: 2
                  }}
      end
    end

    test "lists all pending disputes" do
      use_cassette "list_pending_disputes" do
        assert Dispute.list(status: "pending", limit: 1) ==
                 {:ok,
                  %Omise.List{
                    data: [],
                    from: "1970-01-01T00:00:00Z",
                    limit: 1,
                    location: "/disputes/pending",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T11:59:21Z",
                    total: 0
                  }}
      end
    end

    test "lists all closed disputes" do
      use_cassette "list_closed_disputes" do
        assert Dispute.list(status: "closed", limit: 1) ==
                 {:ok,
                  %Omise.List{
                    data: [],
                    from: "1970-01-01T00:00:00Z",
                    limit: 1,
                    location: "/disputes/closed",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T11:59:20Z",
                    total: 0
                  }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves dispute" do
      use_cassette "retrieve_dispute" do
        assert Dispute.retrieve("dspt_test_59uu7g9ijua6xcbd3yg") ==
                 {:ok,
                  %Omise.Dispute{
                    amount: 50000,
                    charge: "chrg_test_59utsg8rdkbgfgdztay",
                    closed_at: nil,
                    created: "2017-11-04T12:02:34Z",
                    currency: "thb",
                    documents: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/disputes/dspt_test_59uu7g9ijua6xcbd3yg/documents",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T12:03:10Z",
                      total: 0
                    },
                    id: "dspt_test_59uu7g9ijua6xcbd3yg",
                    livemode: false,
                    location: "/disputes/dspt_test_59uu7g9ijua6xcbd3yg",
                    message: nil,
                    object: "dispute",
                    reason_code: "goods_or_services_not_provided",
                    reason_message: "Services not provided or Merchandise not received",
                    status: "open",
                    transaction: "trxn_test_59uu7g9vwd1kr6714pm"
                  }}
      end
    end
  end

  describe "update/3" do
    test "updates dispute" do
      use_cassette "update_dispute" do
        assert Dispute.update("dspt_test_59uu9r7em9ynw5n6ce8", message: "bad charge") ==
                 {:ok,
                  %Omise.Dispute{
                    amount: 50000,
                    charge: "chrg_test_59utsg0q0mf94fp2qvu",
                    closed_at: nil,
                    created: "2017-11-04T12:09:06Z",
                    currency: "thb",
                    documents: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/disputes/dspt_test_59uu9r7em9ynw5n6ce8/documents",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T12:09:31Z",
                      total: 0
                    },
                    id: "dspt_test_59uu9r7em9ynw5n6ce8",
                    livemode: false,
                    location: "/disputes/dspt_test_59uu9r7em9ynw5n6ce8",
                    message: "bad charge",
                    object: "dispute",
                    reason_code: "goods_or_services_not_provided",
                    reason_message: "Services not provided or Merchandise not received",
                    status: "pending",
                    transaction: "trxn_test_59uu9r7mkpj2ndax49d"
                  }}
      end
    end
  end

  describe "search/2" do
    test "searches all disputes" do
      use_cassette "search_disputes" do
        assert Dispute.search(query: "bad") ==
                 {:ok,
                  %Omise.Search{
                    data: [
                      %Omise.Dispute{
                        amount: 50000,
                        charge: "chrg_test_59utsg0q0mf94fp2qvu",
                        closed_at: nil,
                        created: "2017-11-04T12:09:06Z",
                        currency: "thb",
                        documents: %Omise.List{
                          data: [],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/disputes/dspt_test_59uu9r7em9ynw5n6ce8/documents",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T12:09:56Z",
                          total: 0
                        },
                        id: "dspt_test_59uu9r7em9ynw5n6ce8",
                        livemode: false,
                        location: "/disputes/dspt_test_59uu9r7em9ynw5n6ce8",
                        message: "bad charge",
                        object: "dispute",
                        reason_code: "goods_or_services_not_provided",
                        reason_message: "Services not provided or Merchandise not received",
                        status: "pending",
                        transaction: "trxn_test_59uu9r7mkpj2ndax49d"
                      }
                    ],
                    filters: %{},
                    location: "/search",
                    object: "search",
                    page: 1,
                    query: "bad",
                    scope: "dispute",
                    total: 1,
                    total_pages: 1
                  }}
      end
    end
  end

  describe "list_documents/3" do
    test "lists dispute documents" do
      use_cassette "list_documents" do
        assert Dispute.list_documents("dspt_test_59uuaz72tx6inasbfuj") ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Document{
                        deleted: false,
                        filename: "cat_pic.jpg",
                        id: "docu_test_59uubg00s3hlytq56jz",
                        livemode: false,
                        location: "/disputes/dspt_test_59uuaz72tx6inasbfuj/documents/docu_test_59uubg00s3hlytq56jz",
                        object: "document"
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 20,
                    location: "/disputes/dspt_test_59uuaz72tx6inasbfuj/documents",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T12:16:35Z",
                    total: 1
                  }}
      end
    end
  end

  describe "retrieve_document/3" do
    test "retrieves document" do
      use_cassette "retrieve_document" do
        assert Dispute.retrieve_document("dspt_test_59uuaz72tx6inasbfuj", "docu_test_59uubg00s3hlytq56jz") ==
                 {:ok,
                  %Omise.Document{
                    deleted: false,
                    filename: "cat_pic.jpg",
                    id: "docu_test_59uubg00s3hlytq56jz",
                    livemode: false,
                    location: "/disputes/dspt_test_59uuaz72tx6inasbfuj/documents/docu_test_59uubg00s3hlytq56jz",
                    object: "document"
                  }}
      end
    end
  end

  describe "upload_document/3" do
    test "uploads document with valid file" do
      use_cassette "upload_document_with_valid_file" do
        assert Dispute.upload_document("dspt_test_59uuaz72tx6inasbfuj", file: "cat_pic.jpg") ==
                 {:ok,
                  %Omise.Document{
                    deleted: false,
                    filename: "cat_pic.jpg",
                    id: "docu_test_59uubg00s3hlytq56jz",
                    livemode: false,
                    location: "/disputes/dspt_test_59uuaz72tx6inasbfuj/documents/docu_test_59uubg00s3hlytq56jz",
                    object: "document"
                  }}
      end
    end

    test "uploads document with invalid file" do
      use_cassette "upload_document_with_invalid_file" do
        assert Dispute.upload_document("dspt_test_59uuaz72tx6inasbfuj", file: "README.md") ==
                 {:error,
                  %Omise.Error{
                    code: "invalid_file_type",
                    location: "https://www.omise.co/api-errors#invalid-file-type",
                    message: "invalid content-type",
                    object: "error"
                  }}
      end
    end
  end

  describe "destroy_document/3" do
    test "destroys document" do
      use_cassette "destroy_document" do
        assert Dispute.destroy_document("dspt_test_59uuaz72tx6inasbfuj", "docu_test_59uubg00s3hlytq56jz") ==
                 {:ok,
                  %Omise.Document{
                    deleted: true,
                    filename: nil,
                    id: "docu_test_59uubg00s3hlytq56jz",
                    livemode: false,
                    location: nil,
                    object: "document"
                  }}
      end
    end
  end
end
