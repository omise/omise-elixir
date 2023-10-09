defmodule Omies.ChargeTest do
  use Omise.TestCase, async: true

  alias Omise.Charge

  setup do: set_fixture_dir("charge")

  describe "list/1" do
    test "lists all charges" do
      use_cassette "list_charges" do
        assert Charge.list(limit: 2, order: "reverse_chronological") ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Charge{
                        amount: 50000,
                        authorize_uri: nil,
                        authorized: true,
                        capture: true,
                        captured: nil,
                        card: %Omise.Card{
                          bank: "",
                          brand: "Visa",
                          city: "Bangkok",
                          country: "us",
                          created: "2017-11-04T08:51:46Z",
                          deleted: false,
                          expiration_month: 10,
                          expiration_year: 2019,
                          financing: "",
                          fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                          id: "card_test_59uscaex8yhxq6nowz6",
                          last_digits: "4242",
                          livemode: false,
                          location: nil,
                          name: "John Doe",
                          object: "card",
                          postal_code: "10320",
                          security_code_check: true
                        },
                        created: "2017-11-04T08:52:08Z",
                        currency: "thb",
                        customer: nil,
                        description: nil,
                        dispute: nil,
                        failure_code: nil,
                        failure_message: nil,
                        id: "chrg_test_59uscezieqs255upg9u",
                        installment_terms: nil,
                        ip: nil,
                        livemode: false,
                        location: "/charges/chrg_test_59uscezieqs255upg9u",
                        metadata: %{},
                        object: "charge",
                        offline: nil,
                        offsite: nil,
                        paid: true,
                        reference: nil,
                        refunded: 0,
                        refunds: %Omise.List{
                          data: [],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/charges/chrg_test_59uscezieqs255upg9u/refunds",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T08:52:08Z",
                          total: 0
                        },
                        return_uri: nil,
                        reversed: false,
                        source: nil,
                        source_of_fund: nil,
                        status: "successful",
                        transaction: "trxn_test_59uscf1dzpaux0vdnp7"
                      },
                      %Omise.Charge{
                        amount: 50000,
                        authorize_uri: nil,
                        authorized: true,
                        capture: true,
                        captured: nil,
                        card: %Omise.Card{
                          bank: "",
                          brand: "Visa",
                          city: "Bangkok",
                          country: "us",
                          created: "2017-11-04T08:50:33Z",
                          deleted: false,
                          expiration_month: 10,
                          expiration_year: 2019,
                          financing: "",
                          fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                          id: "card_test_59usbuxuol8ns0ef415",
                          last_digits: "4242",
                          livemode: false,
                          location: nil,
                          name: "John Doe",
                          object: "card",
                          postal_code: "10320",
                          security_code_check: true
                        },
                        created: "2017-11-04T08:50:51Z",
                        currency: "thb",
                        customer: nil,
                        description: nil,
                        dispute: nil,
                        failure_code: nil,
                        failure_message: nil,
                        id: "chrg_test_59usbyp8hvd8vw93hwj",
                        installment_terms: nil,
                        ip: nil,
                        livemode: false,
                        location: "/charges/chrg_test_59usbyp8hvd8vw93hwj",
                        metadata: %{},
                        object: "charge",
                        offline: nil,
                        offsite: nil,
                        paid: true,
                        reference: nil,
                        refunded: 0,
                        refunds: %Omise.List{
                          data: [],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/charges/chrg_test_59usbyp8hvd8vw93hwj/refunds",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T08:52:08Z",
                          total: 0
                        },
                        return_uri: nil,
                        reversed: false,
                        source: nil,
                        source_of_fund: nil,
                        status: "successful",
                        transaction: "trxn_test_59usbyrwtbdujixpga1"
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 2,
                    location: "/charges",
                    object: "list",
                    offset: 0,
                    order: "reverse_chronological",
                    to: "2017-11-04T08:52:08Z",
                    total: 2321
                  }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves charge with given id" do
      use_cassette "retrieve_charge" do
        assert Charge.retrieve("chrg_test_59ur0ja5pn1aywe2czq") ==
                 {:ok,
                  %Omise.Charge{
                    amount: 450_000,
                    authorize_uri: nil,
                    authorized: true,
                    capture: true,
                    captured: nil,
                    card: %Omise.Card{
                      bank: "",
                      brand: "Visa",
                      city: "Bangkok",
                      country: "us",
                      created: "2017-11-04T06:35:41Z",
                      deleted: false,
                      expiration_month: 10,
                      expiration_year: 2019,
                      financing: "",
                      fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                      id: "card_test_59ur0dqgzaw2sl0yc4q",
                      last_digits: "4242",
                      livemode: false,
                      location: nil,
                      name: "John Doe",
                      object: "card",
                      postal_code: "10320",
                      security_code_check: true
                    },
                    created: "2017-11-04T06:36:07Z",
                    currency: "thb",
                    customer: nil,
                    description: nil,
                    dispute: nil,
                    failure_code: nil,
                    failure_message: nil,
                    id: "chrg_test_59ur0ja5pn1aywe2czq",
                    installment_terms: nil,
                    ip: nil,
                    livemode: false,
                    location: "/charges/chrg_test_59ur0ja5pn1aywe2czq",
                    metadata: %{},
                    object: "charge",
                    offline: nil,
                    offsite: nil,
                    paid: true,
                    reference: nil,
                    refunded: 0,
                    refunds: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/charges/chrg_test_59ur0ja5pn1aywe2czq/refunds",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T08:52:07Z",
                      total: 0
                    },
                    return_uri: nil,
                    reversed: false,
                    source: nil,
                    source_of_fund: nil,
                    status: "successful",
                    transaction: "trxn_test_59ur0jca0mv51z6laom"
                  }}
      end
    end
  end

  describe "create/2" do
    test "creates charge with token" do
      use_cassette "create_charge_with_token" do
        assert Charge.create(
                 amount: 50000,
                 currency: "thb",
                 card: "tokn_test_59uscaeyd5kfjg8czrh"
               ) ==
                 {:ok,
                  %Omise.Charge{
                    amount: 50000,
                    authorize_uri: nil,
                    authorized: true,
                    capture: true,
                    captured: nil,
                    card: %Omise.Card{
                      bank: "",
                      brand: "Visa",
                      city: "Bangkok",
                      country: "us",
                      created: "2017-11-04T08:51:46Z",
                      deleted: false,
                      expiration_month: 10,
                      expiration_year: 2019,
                      financing: "",
                      fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                      id: "card_test_59uscaex8yhxq6nowz6",
                      last_digits: "4242",
                      livemode: false,
                      location: nil,
                      name: "John Doe",
                      object: "card",
                      postal_code: "10320",
                      security_code_check: true
                    },
                    created: "2017-11-04T08:52:08Z",
                    currency: "thb",
                    customer: nil,
                    description: nil,
                    dispute: nil,
                    failure_code: nil,
                    failure_message: nil,
                    id: "chrg_test_59uscezieqs255upg9u",
                    installment_terms: nil,
                    ip: nil,
                    livemode: false,
                    location: "/charges/chrg_test_59uscezieqs255upg9u",
                    metadata: %{},
                    object: "charge",
                    offline: nil,
                    offsite: nil,
                    paid: true,
                    reference: nil,
                    refunded: 0,
                    refunds: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/charges/chrg_test_59uscezieqs255upg9u/refunds",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T08:52:08Z",
                      total: 0
                    },
                    return_uri: nil,
                    reversed: false,
                    source: nil,
                    source_of_fund: nil,
                    status: "successful",
                    transaction: "trxn_test_59uscf1dzpaux0vdnp7"
                  }}
      end
    end

    test "creates charge with customer" do
      use_cassette "create_charge_with_customer" do
        assert Charge.create(
                 amount: 50000,
                 currency: "thb",
                 customer: "cust_test_59ur2ob5ltcsl9vjwb4"
               ) ==
                 {:ok,
                  %Omise.Charge{
                    amount: 50000,
                    authorize_uri: nil,
                    authorized: true,
                    capture: true,
                    captured: nil,
                    card: %Omise.Card{
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
                    },
                    created: "2017-11-04T08:57:02Z",
                    currency: "thb",
                    customer: "cust_test_59ur2ob5ltcsl9vjwb4",
                    description: nil,
                    dispute: nil,
                    failure_code: nil,
                    failure_message: nil,
                    id: "chrg_test_59use551gec8gaockk7",
                    installment_terms: nil,
                    ip: nil,
                    livemode: false,
                    location: "/charges/chrg_test_59use551gec8gaockk7",
                    metadata: %{},
                    object: "charge",
                    offline: nil,
                    offsite: nil,
                    paid: true,
                    reference: nil,
                    refunded: 0,
                    refunds: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/charges/chrg_test_59use551gec8gaockk7/refunds",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T08:57:03Z",
                      total: 0
                    },
                    return_uri: nil,
                    reversed: false,
                    source: nil,
                    source_of_fund: nil,
                    status: "successful",
                    transaction: "trxn_test_59use57kldk75i8br9b"
                  }}
      end
    end

    test "creates charge with customer and card" do
      use_cassette "create_charge_with_customer_and_card" do
        assert Charge.create(
                 amount: 50000,
                 currency: "thb",
                 customer: "cust_test_59ur2ob5ltcsl9vjwb4",
                 card: "card_test_59ur2aloj4ofih2m8ct"
               ) ==
                 {:ok,
                  %Omise.Charge{
                    amount: 50000,
                    authorize_uri: nil,
                    authorized: true,
                    capture: true,
                    captured: nil,
                    card: %Omise.Card{
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
                    },
                    created: "2017-11-04T08:58:37Z",
                    currency: "thb",
                    customer: "cust_test_59ur2ob5ltcsl9vjwb4",
                    description: nil,
                    dispute: nil,
                    failure_code: nil,
                    failure_message: nil,
                    id: "chrg_test_59usep2shcycq9vrn70",
                    installment_terms: nil,
                    ip: nil,
                    livemode: false,
                    location: "/charges/chrg_test_59usep2shcycq9vrn70",
                    metadata: %{},
                    object: "charge",
                    offline: nil,
                    offsite: nil,
                    paid: true,
                    reference: nil,
                    refunded: 0,
                    refunds: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/charges/chrg_test_59usep2shcycq9vrn70/refunds",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T08:58:37Z",
                      total: 0
                    },
                    return_uri: nil,
                    reversed: false,
                    source: nil,
                    source_of_fund: nil,
                    status: "successful",
                    transaction: "trxn_test_59usep4owrp5i83x4dq"
                  }}
      end
    end

    test "creates charge with source" do
      use_cassette "create_charge_with_source" do
        assert Charge.create(
                 [
                   amount: 1000_00,
                   currency: "thb",
                   return_uri: "https://example.com/orders/123/complete",
                   source: "src_test_59vbms154ab4pe4jh2i"
                 ],
                 api_version: "2017-11-02"
               ) ==
                 {:ok,
                  %Omise.Charge{
                    amount: 100_000,
                    authorize_uri: "https://pay.omise.co/offsites/ofsp_test_59vbnbnlmlkeauu9yxq/pay",
                    authorized: false,
                    capture: true,
                    captured: nil,
                    card: nil,
                    created: "2017-11-05T17:46:12Z",
                    currency: "thb",
                    customer: nil,
                    description: nil,
                    dispute: nil,
                    failure_code: nil,
                    failure_message: nil,
                    id: "chrg_test_59vbnbnjorfk2x5nand",
                    installment_terms: nil,
                    ip: nil,
                    livemode: false,
                    location: "/charges/chrg_test_59vbnbnjorfk2x5nand",
                    metadata: %{},
                    object: "charge",
                    offline: nil,
                    offsite: nil,
                    paid: false,
                    reference: "ofsp_test_59vbnbnlmlkeauu9yxq",
                    refunded: 0,
                    refunds: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/charges/chrg_test_59vbnbnjorfk2x5nand/refunds",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-05T17:46:12Z",
                      total: 0
                    },
                    return_uri: "https://example.com/orders/123/complete",
                    reversed: false,
                    source: %Omise.Source{
                      amount: 100_000,
                      currency: "thb",
                      flow: "redirect",
                      id: "src_test_59vbms154ab4pe4jh2i",
                      object: "source",
                      type: "internet_banking_bbl"
                    },
                    source_of_fund: nil,
                    status: "pending",
                    transaction: nil
                  }}
      end
    end

    test "creates charge with invalid token" do
      use_cassette "create_charge_with_invalid_token" do
        assert Charge.create(
                 amount: 50000,
                 currency: "thb",
                 card: "invalid_token"
               ) ==
                 {:error,
                  %Omise.Error{
                    code: "not_found",
                    location: "https://www.omise.co/api-errors#not-found",
                    message: "token invalid_token was not found",
                    object: "error"
                  }}
      end
    end

    test "creates charge with used token" do
      use_cassette "create_charge_with_used_token" do
        assert Charge.create(
                 amount: 50000,
                 currency: "thb",
                 card: "tokn_test_59usgcsw7es0ilk0514"
               ) ==
                 {:error,
                  %Omise.Error{
                    object: "error",
                    code: "used_token",
                    location: "https://www.omise.co/api-errors#used-token",
                    message: "token was already used"
                  }}
      end
    end

    test "creates charge with invalid amount" do
      use_cassette "create_charge_with_invalid_amount" do
        assert Charge.create(
                 amount: 10,
                 currency: "thb",
                 customer: "cust_test_59ur2ob5ltcsl9vjwb4"
               ) ==
                 {:error,
                  %Omise.Error{
                    code: "invalid_charge",
                    location: "https://www.omise.co/api-errors#invalid-charge",
                    message: "amount must be greater than or equal to 2000 (thb subunits)",
                    object: "error"
                  }}
      end
    end

    test "creates charge with invalid currency" do
      use_cassette "create_charge_with_invalid_currency" do
        assert Charge.create(
                 amount: 10000,
                 currency: "invalid",
                 customer: "cust_test_59ur2ob5ltcsl9vjwb4"
               ) ==
                 {:error,
                  %Omise.Error{
                    code: "invalid_charge",
                    location: "https://www.omise.co/api-errors#invalid-charge",
                    object: "error",
                    message: "currency is currently not supported"
                  }}
      end
    end
  end

  describe "update/3" do
    test "updates charge" do
      use_cassette "update_charge" do
        assert Charge.update("chrg_test_59ur0ja5pn1aywe2czq", description: "New description") ==
                 {:ok,
                  %Omise.Charge{
                    amount: 450_000,
                    authorize_uri: nil,
                    authorized: true,
                    capture: true,
                    captured: nil,
                    card: %Omise.Card{
                      bank: "",
                      brand: "Visa",
                      city: "Bangkok",
                      country: "us",
                      created: "2017-11-04T06:35:41Z",
                      deleted: false,
                      expiration_month: 10,
                      expiration_year: 2019,
                      financing: "",
                      fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                      id: "card_test_59ur0dqgzaw2sl0yc4q",
                      last_digits: "4242",
                      livemode: false,
                      location: nil,
                      name: "John Doe",
                      object: "card",
                      postal_code: "10320",
                      security_code_check: true
                    },
                    created: "2017-11-04T06:36:07Z",
                    currency: "thb",
                    customer: nil,
                    description: "New description",
                    dispute: nil,
                    failure_code: nil,
                    failure_message: nil,
                    id: "chrg_test_59ur0ja5pn1aywe2czq",
                    installment_terms: nil,
                    ip: nil,
                    livemode: false,
                    location: "/charges/chrg_test_59ur0ja5pn1aywe2czq",
                    metadata: %{},
                    object: "charge",
                    offline: nil,
                    offsite: nil,
                    paid: true,
                    reference: nil,
                    refunded: 0,
                    refunds: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/charges/chrg_test_59ur0ja5pn1aywe2czq/refunds",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T09:01:45Z",
                      total: 0
                    },
                    return_uri: nil,
                    reversed: false,
                    source: nil,
                    source_of_fund: nil,
                    status: "successful",
                    transaction: "trxn_test_59ur0jca0mv51z6laom"
                  }}
      end
    end
  end

  describe "capture/2" do
    test "captures charge" do
      use_cassette "capture_charge" do
        assert Charge.capture("chrg_test_59usgo8ll198f7473cs") ==
                 {:ok,
                  %Omise.Charge{
                    amount: 50000,
                    authorize_uri: nil,
                    authorized: true,
                    capture: false,
                    captured: nil,
                    card: %Omise.Card{
                      bank: "",
                      brand: "Visa",
                      city: "Bangkok",
                      country: "us",
                      created: "2017-11-04T09:03:19Z",
                      deleted: false,
                      expiration_month: 10,
                      expiration_year: 2019,
                      financing: "",
                      fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                      id: "card_test_59usgcsv3e22bcznla6",
                      last_digits: "4242",
                      livemode: false,
                      location: nil,
                      name: "John Doe",
                      object: "card",
                      postal_code: "10320",
                      security_code_check: true
                    },
                    created: "2017-11-04T09:04:13Z",
                    currency: "thb",
                    customer: nil,
                    description: nil,
                    dispute: nil,
                    failure_code: nil,
                    failure_message: nil,
                    id: "chrg_test_59usgo8ll198f7473cs",
                    installment_terms: nil,
                    ip: nil,
                    livemode: false,
                    location: "/charges/chrg_test_59usgo8ll198f7473cs",
                    metadata: %{},
                    object: "charge",
                    offline: nil,
                    offsite: nil,
                    paid: true,
                    reference: nil,
                    refunded: 0,
                    refunds: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/charges/chrg_test_59usgo8ll198f7473cs/refunds",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T09:06:54Z",
                      total: 0
                    },
                    return_uri: nil,
                    reversed: false,
                    source: nil,
                    source_of_fund: nil,
                    status: "successful",
                    transaction: "trxn_test_59ushm59uy5kf6o909e"
                  }}
      end
    end

    test "partial capture a charge" do
      use_cassette "capture_charge_partial" do
        assert Charge.capture("chrg_test_59usgo8ll198f7473cs", capture_amount: 3000) ==
                 {:ok,
                  %Omise.Charge{
                    amount: 50000,
                    authorization_type: "pre_auth",
                    authorized_amount: 50000,
                    captured_amount: 3000,
                    authorize_uri: nil,
                    authorized: true,
                    capture: false,
                    captured: nil,
                    card: %Omise.Card{
                      bank: "",
                      brand: "Visa",
                      city: "Bangkok",
                      country: "us",
                      created: "2017-11-04T09:03:19Z",
                      deleted: false,
                      expiration_month: 10,
                      expiration_year: 2019,
                      financing: "",
                      fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                      id: "card_test_59usgcsv3e22bcznla6",
                      last_digits: "4242",
                      livemode: false,
                      location: nil,
                      name: "John Doe",
                      object: "card",
                      postal_code: "10320",
                      security_code_check: true
                    },
                    created: "2017-11-04T09:04:13Z",
                    currency: "thb",
                    customer: nil,
                    description: nil,
                    dispute: nil,
                    failure_code: nil,
                    failure_message: nil,
                    id: "chrg_test_59usgo8ll198f7473cs",
                    installment_terms: nil,
                    ip: nil,
                    livemode: false,
                    location: "/charges/chrg_test_59usgo8ll198f7473cs",
                    metadata: %{},
                    object: "charge",
                    offline: nil,
                    offsite: nil,
                    paid: true,
                    reference: nil,
                    refunded: 0,
                    refunds: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/charges/chrg_test_59usgo8ll198f7473cs/refunds",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T09:06:54Z",
                      total: 0
                    },
                    return_uri: nil,
                    reversed: false,
                    source: nil,
                    source_of_fund: nil,
                    status: "successful",
                    transaction: "trxn_test_59ushm59uy5kf6o909e"
                  }}
      end
    end
  end

  describe "reverse/2" do
    test "reverses uncaptured charge" do
      use_cassette "reverse_uncaptured_charge" do
        assert Charge.reverse("chrg_test_59usn68i08xgf6fcarq") ==
                 {:ok,
                  %Omise.Charge{
                    amount: 50000,
                    authorize_uri: nil,
                    authorized: true,
                    capture: false,
                    captured: nil,
                    card: %Omise.Card{
                      bank: "",
                      brand: "Visa",
                      city: "Bangkok",
                      country: "us",
                      created: "2017-11-04T09:22:26Z",
                      deleted: false,
                      expiration_month: 10,
                      expiration_year: 2019,
                      financing: "",
                      fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                      id: "card_test_59usn2yf9kkacdwvxt5",
                      last_digits: "4242",
                      livemode: false,
                      location: nil,
                      name: "John Doe",
                      object: "card",
                      postal_code: "10320",
                      security_code_check: true
                    },
                    created: "2017-11-04T09:22:41Z",
                    currency: "thb",
                    customer: nil,
                    description: nil,
                    dispute: nil,
                    failure_code: nil,
                    failure_message: nil,
                    id: "chrg_test_59usn68i08xgf6fcarq",
                    installment_terms: nil,
                    ip: nil,
                    livemode: false,
                    location: "/charges/chrg_test_59usn68i08xgf6fcarq",
                    metadata: %{},
                    object: "charge",
                    offline: nil,
                    offsite: nil,
                    paid: false,
                    reference: nil,
                    refunded: 0,
                    refunds: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/charges/chrg_test_59usn68i08xgf6fcarq/refunds",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T09:23:18Z",
                      total: 0
                    },
                    return_uri: nil,
                    reversed: true,
                    source: nil,
                    source_of_fund: nil,
                    status: "reversed",
                    transaction: nil
                  }}
      end
    end

    test "reverses captured charge" do
      use_cassette "reverse_captured_charge" do
        assert Charge.reverse("chrg_test_556qgv7yxa759kavn8v") ==
                 {:error,
                  %Omise.Error{
                    object: "error",
                    code: "failed_reverse",
                    location: "https://www.omise.co/api-errors#failed-reverse",
                    message: "only uncaptured authorized charges can be reversed"
                  }}
      end
    end
  end

  describe "search/2" do
    test "searches all charges" do
      use_cassette "search_charges" do
        assert Charge.search(query: "adele") ==
                 {:ok,
                  %Omise.Search{
                    data: [
                      %Omise.Charge{
                        amount: 50000,
                        authorize_uri: nil,
                        authorized: true,
                        capture: true,
                        captured: nil,
                        card: %Omise.Card{
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
                        },
                        created: "2017-11-04T08:58:37Z",
                        currency: "thb",
                        customer: "cust_test_59ur2ob5ltcsl9vjwb4",
                        description: nil,
                        dispute: nil,
                        failure_code: nil,
                        failure_message: nil,
                        id: "chrg_test_59usep2shcycq9vrn70",
                        installment_terms: nil,
                        ip: nil,
                        livemode: false,
                        location: "/charges/chrg_test_59usep2shcycq9vrn70",
                        metadata: %{},
                        object: "charge",
                        offline: nil,
                        offsite: nil,
                        paid: true,
                        reference: nil,
                        refunded: 0,
                        refunds: %Omise.List{
                          data: [],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/charges/chrg_test_59usep2shcycq9vrn70/refunds",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T09:33:57Z",
                          total: 0
                        },
                        return_uri: nil,
                        reversed: false,
                        source: nil,
                        source_of_fund: nil,
                        status: "successful",
                        transaction: "trxn_test_59usep4owrp5i83x4dq"
                      },
                      %Omise.Charge{
                        amount: 50000,
                        authorize_uri: nil,
                        authorized: true,
                        capture: true,
                        captured: nil,
                        card: %Omise.Card{
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
                        },
                        created: "2017-11-04T08:57:02Z",
                        currency: "thb",
                        customer: "cust_test_59ur2ob5ltcsl9vjwb4",
                        description: nil,
                        dispute: nil,
                        failure_code: nil,
                        failure_message: nil,
                        id: "chrg_test_59use551gec8gaockk7",
                        installment_terms: nil,
                        ip: nil,
                        livemode: false,
                        location: "/charges/chrg_test_59use551gec8gaockk7",
                        metadata: %{},
                        object: "charge",
                        offline: nil,
                        offsite: nil,
                        paid: true,
                        reference: nil,
                        refunded: 0,
                        refunds: %Omise.List{
                          data: [],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/charges/chrg_test_59use551gec8gaockk7/refunds",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T09:33:57Z",
                          total: 0
                        },
                        return_uri: nil,
                        reversed: false,
                        source: nil,
                        source_of_fund: nil,
                        status: "successful",
                        transaction: "trxn_test_59use57kldk75i8br9b"
                      }
                    ],
                    filters: %{},
                    location: "/search",
                    object: "search",
                    page: 1,
                    query: "adele",
                    scope: "charge",
                    total: 2,
                    total_pages: 1,
                    order: "chronological",
                    per_page: 30
                  }}
      end
    end
  end

  describe "refund/2" do
    test "refunds charge" do
      use_cassette "refund_charge" do
        assert Charge.refund("chrg_test_59use551gec8gaockk7", amount: 10000) ==
                 {:ok,
                  %Omise.Refund{
                    amount: 10000,
                    charge: "chrg_test_59use551gec8gaockk7",
                    created: "2017-11-04T09:36:45Z",
                    currency: "thb",
                    id: "rfnd_test_59uss4fpv3otofm2ri1",
                    location: "/charges/chrg_test_59use551gec8gaockk7/refunds/rfnd_test_59uss4fpv3otofm2ri1",
                    object: "refund",
                    transaction: "trxn_test_59uss4fwydrqn3ddwlg",
                    voided: false
                  }}
      end
    end
  end

  describe "list_refunds/3" do
    test "lists all refunds with given charge_id" do
      use_cassette "list_refunds" do
        assert Charge.list_refunds("chrg_test_59use551gec8gaockk7", limit: 2) ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Refund{
                        amount: 10000,
                        charge: "chrg_test_59use551gec8gaockk7",
                        created: "2017-11-04T09:36:45Z",
                        currency: "thb",
                        id: "rfnd_test_59uss4fpv3otofm2ri1",
                        location: "/charges/chrg_test_59use551gec8gaockk7/refunds/rfnd_test_59uss4fpv3otofm2ri1",
                        object: "refund",
                        transaction: "trxn_test_59uss4fwydrqn3ddwlg",
                        voided: false
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 2,
                    location: "/charges/chrg_test_59use551gec8gaockk7/refunds",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T09:39:37Z",
                    total: 1
                  }}
      end
    end
  end

  describe "retrieve_refund/3" do
    test "retrieves refund with charge_id and refund_id" do
      use_cassette "retrieve_refund" do
        assert Charge.retrieve_refund("chrg_test_59use551gec8gaockk7", "rfnd_test_59uss4fpv3otofm2ri1") ==
                 {:ok,
                  %Omise.Refund{
                    amount: 10000,
                    charge: "chrg_test_59use551gec8gaockk7",
                    created: "2017-11-04T09:36:45Z",
                    currency: "thb",
                    id: "rfnd_test_59uss4fpv3otofm2ri1",
                    location: "/charges/chrg_test_59use551gec8gaockk7/refunds/rfnd_test_59uss4fpv3otofm2ri1",
                    object: "refund",
                    transaction: "trxn_test_59uss4fwydrqn3ddwlg",
                    voided: false
                  }}
      end
    end
  end

  describe "list_schedules/2" do
    test "list all charge schedules" do
      use_cassette "list_charge_schedules" do
        assert Charge.list_schedules(limit: 1) ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Schedule{
                        charge: %{
                          "amount" => 10000,
                          "card" => nil,
                          "currency" => "thb",
                          "customer" => "cust_test_55c6cjwyr9kl4rt4jso",
                          "description" => "Let the rain come down!"
                        },
                        created: "2017-05-30T07:25:10Z",
                        end_date: "2018-05-30",
                        every: 1,
                        id: "schd_test_584yqgiuavbzrfng7mv",
                        in_words: "Every 1 day(s)",
                        livemode: false,
                        location: "/schedules/schd_test_584yqgiuavbzrfng7mv",
                        next_occurrence_dates: [],
                        object: "schedule",
                        occurrences: %Omise.List{
                          data: [
                            %Omise.Occurrence{
                              created: "2017-05-30T07:25:10Z",
                              id: "occu_test_584yqgivyi2p1g828pl",
                              livemode: false,
                              location: "/occurrences/occu_test_584yqgivyi2p1g828pl",
                              message: nil,
                              object: "occurrence",
                              processed_at: "2017-05-30T07:25:10Z",
                              result: "chrg_test_584yqgjb0pf8vj3lq1k",
                              retry_date: nil,
                              schedule: "schd_test_584yqgiuavbzrfng7mv",
                              schedule_date: "2017-05-30",
                              status: "successful"
                            }
                          ],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/schedules/schd_test_584yqgiuavbzrfng7mv/occurrences",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T10:01:04Z",
                          total: 1
                        },
                        on: %{},
                        period: "day",
                        start_date: "2017-05-30",
                        status: "deleted",
                        transfer: %{}
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 1,
                    location: "/charges/schedules",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T10:01:04Z",
                    total: 18
                  }}
      end
    end
  end
end
