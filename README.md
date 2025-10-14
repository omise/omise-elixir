# Omise Elixir Client

[![Build Status](https://github.com/omise/omise-elixir/actions/workflows/pipeline.yml/badge.svg)](https://github.com/omise/omise-elixir/actions/workflows/pipeline.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/omise.svg?style=flat-square)](https://hex.pm/packages/omise)
[![Coverage Status](https://coveralls.io/repos/github/omise/omise-elixir/badge.svg?branch=master)](https://coveralls.io/github/omise/omise-elixir?branch=master)

**Opn Payments for Elixir**

## Installation

First, add `omise` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:omise, "~> 0.10.0"}]
end
```

Then update your dependencies with:

```shell
$ mix deps.get
```

## Configuration

Set the following configuration variables in `config/config.exs`:

```elixir
config :omise,
  public_key: "pkey_test_xxx",
  secret_key: "skey_test_xxx"
```

Or manually configure at runtime:

```elixir
Omise.configure(public_key: "pkey_test_xxx", secret_key: "skey_test_xxx")
```

To configure the HTTP options, you could optionally add the `:http_options` key to the Opn Payments configuration. For a full list of the available options, please check [HTTPoison documentation](https://github.com/edgurgel/httpoison).

```elixir
config :omise,
  http_options: [timeout: 60_000, recv_timeout: 60_000]
```

## Example

```elixir
charge_params = [amount: 100_00, currency: "thb", card: "tokn_xxx"]

with {:ok, %Omise.Charge{paid: true}} <- Omise.Charge.create(charge_params) do
  # handle success
  IO.puts "Thank you :)"
else
  {:ok, %Omise.Charge{failure_code: failure_code}} ->
    # handle failure

  {:error, %Omise.Error{code: code, message: message}} ->
    # handle error
end
```

You can also set a per-request key and API version when making an API call:

```elixir
Omise.Charge.list([], key: "skey_test_xxx", api_version: "2015-11-17")

Omise.Charge.retrieve("chrg_test_4yq7duw15p9hdrjp8oq", key: "skey_test_xxx")

Omise.Charge.create([
  amount: 1000_00,
  currency: "thb",
  customer: "cust_test_xxx"
], key: "skey_test_xxx")
```

# Passkey Integration

The Omise Elixir SDK supports Passkey authentication for enhanced security and user experience. Passkey provides a passwordless authentication method that uses biometric authentication or device PINs, making payments more secure and convenient for users.

## Prerequisites

Before implementing Passkey authentication:

- Ensure your Omise account supports Passkey authentication
- Configure your frontend to collect proper card holder data (email/phoneNumber)

## Implementation

### Requesting Cardholder Data

To use Passkey authentication, you must request cardholder data fields (email or phone number) during the payment process on the frontend. This information is required for the backend Passkey authentication setup.

### Creating a Passkey Charge

Once you have created a token on the frontend that includes the email/phoneNumber of the user, you can now use this token to create a passkey charge.
To create a passkey charge you must set the `authentication` field in the charge request to `PASSKEY`. This will trigger the required flows and you will also be able to check the `authenticated_by` field in the charge response in order to check the actual authentication method. Here is an example code for creating a charge with the passkey flow:

```elixir
Omise.Charge.create(
        amount: 10_000,
        currency: "thb",
        card: token.id,
        capture: true,
        return_uri: "https://www.example.com/complete",
        authentication: "PASSKEY"
      )
```

## Development

- Install all dependencies with `mix deps.get`
- Run tests with `mix test`

## Documentation

- [https://hexdocs.pm/omise/api-reference.html](https://hexdocs.pm/omise/api-reference.html)
