defmodule Omise.JsonTest do
  use ExUnit.Case, async: true

  alias Omise.Json

  describe "encode!/1" do
    test "encodes keyword" do
      input = [
        id: 1,
        bank_account: [
          brand: "bbl",
          number: "9999999999"
        ],
        codes: [1, 2, 3]
      ]

      result = Json.encode!(input)

      assert result == "{\"bank_account\":{\"brand\":\"bbl\",\"number\":\"9999999999\"},\"codes\":[1,2,3],\"id\":1}"
    end

    test "encodes map" do
      input = %{
        id: 1,
        bank_account: %{
          brand: "bbl",
          number: "9999999999"
        },
        codes: [1, 2, 3]
      }

      result = Json.encode!(input)

      assert result == "{\"bank_account\":{\"brand\":\"bbl\",\"number\":\"9999999999\"},\"codes\":[1,2,3],\"id\":1}"
    end

    test "encodes keyword and map" do
      input = [
        id: 1,
        bank_account: %{
          brand: "bbl",
          number: "9999999999"
        },
        codes: [1, 2, 3]
      ]

      result = Json.encode!(input)

      assert result == "{\"bank_account\":{\"brand\":\"bbl\",\"number\":\"9999999999\"},\"codes\":[1,2,3],\"id\":1}"
    end

    test "raises an error if the given input is invalid" do
      input = {}

      assert_raise Json.Encoder.Error, fn ->
        Json.encode!(input)
      end
    end
  end

  describe "decode/2" do
    test "decodes the given input without :as option" do
      input =
        "{\n  \"object\": \"account\",\n  \"id\": \"acct_51n45m422m7yrgri706\",\n  \"livemode\": false,\n  \"location\": \"/account\",\n  \"email\": \"m.mantastyle@gmail.com\",\n  \"currency\": \"thb\",\n  \"supported_currencies\": [\n    \"thb\",\n    \"jpy\",\n    \"usd\",\n    \"eur\",\n    \"gbp\",\n    \"sgd\"\n  ],\n  \"created\": \"2016-08-31T05:22:15Z\"\n}\n"

      result = Json.decode(input)

      assert result ==
               {:ok,
                %{
                  "created" => "2016-08-31T05:22:15Z",
                  "currency" => "thb",
                  "email" => "m.mantastyle@gmail.com",
                  "id" => "acct_51n45m422m7yrgri706",
                  "livemode" => false,
                  "location" => "/account",
                  "object" => "account",
                  "supported_currencies" => ["thb", "jpy", "usd", "eur", "gbp", "sgd"]
                }}
    end

    test "decodes the given input with :as option" do
      input =
        "{\n  \"object\": \"list\",\n  \"from\": \"1970-01-01T00:00:00Z\",\n  \"to\": \"2017-11-04T11:17:20Z\",\n  \"offset\": 0,\n  \"limit\": 2,\n  \"total\": 4,\n  \"order\": \"reverse_chronological\",\n  \"location\": \"/customers\",\n  \"data\": [\n    {\n      \"object\": \"customer\",\n      \"id\": \"cust_test_59ur2ob5ltcsl9vjwb4\",\n      \"livemode\": false,\n      \"location\": \"/customers/cust_test_59ur2ob5ltcsl9vjwb4\",\n      \"default_card\": \"card_test_59ur2aloj4ofih2m8ct\",\n      \"email\": \"adele@gmail.com\",\n      \"description\": \"Burnnnn\",\n      \"metadata\": {\n      },\n      \"created\": \"2017-11-04T06:42:11Z\",\n      \"cards\": {\n        \"object\": \"list\",\n        \"from\": \"1970-01-01T00:00:00Z\",\n        \"to\": \"2017-11-04T11:17:20Z\",\n        \"offset\": 0,\n        \"limit\": 20,\n        \"total\": 1,\n        \"order\": null,\n        \"location\": \"/customers/cust_test_59ur2ob5ltcsl9vjwb4/cards\",\n        \"data\": [\n          {\n            \"object\": \"card\",\n            \"id\": \"card_test_59ur2aloj4ofih2m8ct\",\n            \"livemode\": false,\n            \"location\": \"/customers/cust_test_59ur2ob5ltcsl9vjwb4/cards/card_test_59ur2aloj4ofih2m8ct\",\n            \"country\": \"us\",\n            \"city\": \"Bangkok\",\n            \"postal_code\": \"10320\",\n            \"financing\": \"\",\n            \"bank\": \"\",\n            \"last_digits\": \"4242\",\n            \"brand\": \"Visa\",\n            \"expiration_month\": 10,\n            \"expiration_year\": 2019,\n            \"fingerprint\": \"WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=\",\n            \"name\": \"John Doe\",\n            \"security_code_check\": true,\n            \"created\": \"2017-11-04T06:41:07Z\"\n          }\n        ]\n      }\n    },\n    {\n      \"object\": \"customer\",\n      \"id\": \"cust_test_576rin7dke7hxnx8rxc\",\n      \"livemode\": false,\n      \"location\": \"/customers/cust_test_576rin7dke7hxnx8rxc\",\n      \"default_card\": null,\n      \"email\": \"john.smith@example.com\",\n      \"description\": \"Another description\",\n      \"metadata\": {\n      },\n      \"created\": \"2017-03-03T20:52:00Z\",\n      \"cards\": {\n        \"object\": \"list\",\n        \"from\": \"1970-01-01T00:00:00Z\",\n        \"to\": \"2017-11-04T11:17:20Z\",\n        \"offset\": 0,\n        \"limit\": 20,\n        \"total\": 0,\n        \"order\": null,\n        \"location\": \"/customers/cust_test_576rin7dke7hxnx8rxc/cards\",\n        \"data\": [\n\n        ]\n      }\n    }\n  ]\n}\n"

      result = Json.decode(input, as: %Omise.List{data: [%Omise.Customer{}]})

      assert result ==
               {:ok,
                %Omise.List{
                  data: [
                    %Omise.Customer{
                      cards: %Omise.List{
                        data: [
                          %Omise.Card{
                            bank: "",
                            brand: "Visa",
                            city: "Bangkok",
                            country: "us",
                            created: "2017-11-04T06:41:07Z",
                            deleted: false,
                            expiration_month: 10,
                            expiration_year: 2019,
                            financing: "",
                            fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                            id: "card_test_59ur2aloj4ofih2m8ct",
                            last_digits: "4242",
                            livemode: false,
                            location: "/customers/cust_test_59ur2ob5ltcsl9vjwb4/cards/card_test_59ur2aloj4ofih2m8ct",
                            name: "John Doe",
                            object: "card",
                            postal_code: "10320",
                            security_code_check: true
                          }
                        ],
                        from: "1970-01-01T00:00:00Z",
                        limit: 20,
                        location: "/customers/cust_test_59ur2ob5ltcsl9vjwb4/cards",
                        object: "list",
                        offset: 0,
                        order: nil,
                        to: "2017-11-04T11:17:20Z",
                        total: 1
                      },
                      created: "2017-11-04T06:42:11Z",
                      default_card: "card_test_59ur2aloj4ofih2m8ct",
                      deleted: false,
                      description: "Burnnnn",
                      email: "adele@gmail.com",
                      id: "cust_test_59ur2ob5ltcsl9vjwb4",
                      livemode: false,
                      location: "/customers/cust_test_59ur2ob5ltcsl9vjwb4",
                      metadata: %{},
                      object: "customer"
                    },
                    %Omise.Customer{
                      cards: %Omise.List{
                        data: [],
                        from: "1970-01-01T00:00:00Z",
                        limit: 20,
                        location: "/customers/cust_test_576rin7dke7hxnx8rxc/cards",
                        object: "list",
                        offset: 0,
                        order: nil,
                        to: "2017-11-04T11:17:20Z",
                        total: 0
                      },
                      created: "2017-03-03T20:52:00Z",
                      default_card: nil,
                      deleted: false,
                      description: "Another description",
                      email: "john.smith@example.com",
                      id: "cust_test_576rin7dke7hxnx8rxc",
                      livemode: false,
                      location: "/customers/cust_test_576rin7dke7hxnx8rxc",
                      metadata: %{},
                      object: "customer"
                    }
                  ],
                  from: "1970-01-01T00:00:00Z",
                  limit: 2,
                  location: "/customers",
                  object: "list",
                  offset: 0,
                  order: "reverse_chronological",
                  to: "2017-11-04T11:17:20Z",
                  total: 4
                }}
    end

    test "returns error tuple if the given input data is invalid" do
      input = "invalid data input"

      result = Json.decode(input)

      assert result == {:error, :invalid_input_data}
    end
  end
end
