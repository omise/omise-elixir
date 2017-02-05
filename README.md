# Omise Elixir Client
[![Build Status](https://travis-ci.org/omise/omise-elixir.svg)](https://travis-ci.org/omise/omise-elixir)
[![Hex.pm](https://img.shields.io/hexpm/v/omise.svg?style=flat-square)](https://hex.pm/packages/omise)

**Omise for Elixir**

## Installation

  1. Add omise to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:omise, "~> 0.4"}]
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

## Example

```elixir
response = Omise.Charge.create(
  amount: 1000_00,
  currency: "thb",
  card: "tokn_51w6fvilnsxalda4cih"
)

case response do
  {:ok, charge} ->
    # handle success
  {:error, error} ->
    # handle failure
end
```

You can also set a per-request key when making an API call:

```elixir
Omise.Charge.list([], key: "skey_test_xxx")

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
