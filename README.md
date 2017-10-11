# Omise Elixir Client
[![Build Status](https://travis-ci.org/omise/omise-elixir.svg)](https://travis-ci.org/omise/omise-elixir)
[![Hex.pm](https://img.shields.io/hexpm/v/omise.svg?style=flat-square)](https://hex.pm/packages/omise)

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

with {:ok, %{paid: true}} <- Omise.Charge.create(charge_params) do
  # handle success
  IO.puts "Thank you :)"
else
  {:ok, %{failure_code: failure_code}} ->
    # handle failure

  {:error, %{code: code, message: message}} ->
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

It is possible to disable the decoding process which is set to `true` by default. This is achieved by configuring `decode` option in config file or pass it as an option in the function.

```elixir
# config.exs
config :omise, decode: false

# code.ex
Omise.Account.retrieve(decode: false)

```

## Development

- Install all dependencies with `mix deps.get`
- Run tests with `mix test`

## Documentation

 * http://hexdocs.pm/omise/
