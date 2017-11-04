# Omise Elixir Client
[![Build Status](https://travis-ci.org/omise/omise-elixir.svg)](https://travis-ci.org/omise/omise-elixir)
[![Hex.pm](https://img.shields.io/hexpm/v/omise.svg?style=flat-square)](https://hex.pm/packages/omise)
[![Coverage Status](https://coveralls.io/repos/github/omise/omise-elixir/badge.svg?branch=master)](https://coveralls.io/github/omise/omise-elixir?branch=master)

**Omise for Elixir**

## Installation

  1. Add omise to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:omise, "~> 0.5"}]
  end
  ```

  2. Ensure omise is started before your application:

  ```elixir
  def application do
    [applications: [:omise]]
  end
  ```

## Configuration

Set the following configuration variables in `config/config.exs` file:

```elixir
config :omise,
  public_key: "pkey_test_xxx",
  secret_key: "skey_test_xxx"
```

Or manually configure at runtime:

```elixir
Omise.configure(public_key: "pkey_test_xxx", secret_key: "skey_test_xxx")
```

To configure the HTTP options, you could optionally add `:http_options` key to the omise configuration. For a full list of the available options, please check [HTTPoison documentation](https://github.com/edgurgel/httpoison).

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

You can also set a per-request key and api version when making an API call:

```elixir
Omise.Charge.list([], key: "skey_test_xxx", api_version: "2015-11-17")

Omise.Charge.retrieve("chrg_test_4yq7duw15p9hdrjp8oq", key: "skey_test_xxx")

Omise.Charge.create([
  amount: 1000_00,
  currency: "thb",
  customer: "cust_test_xxx"
], key: "skey_test_xxx")
```

## Development

- Install all dependencies with `mix deps.get`
- Run tests with `mix test`

## Documentation

 * http://hexdocs.pm/omise/
