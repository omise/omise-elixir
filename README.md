# Omise
[![Build Status](https://travis-ci.org/teerawat1992/omise.svg?branch=master)](https://travis-ci.org/teerawat1992/omise)
[![Hex.pm](https://img.shields.io/hexpm/v/omise.svg?style=flat-square)](https://hex.pm/packages/omise)

**Omise for Elixir**

## Installation

  1. Add omise to your list of dependencies in `mix.exs`:

        def deps do
          [{:omise, "~> 0.1.2"}]
        end

  2. Ensure omise is started before your application:

        def application do
          [applications: [:omise]]
        end

## Configuration

Set the following configuration variables in `config/config.exs` file:

```elixir
config :omise,
  public_key: "OMISE_PUBLIC_KEY",
  secret_key: "OMISE_SECRET_KEY"
```

Or manually configure at runtime:

```elixir
Omise.configure(public_key: "OMISE_PUBLIC_KEY", secret_key: "OMISE_SECRET_KEY")
```

## Example

```elixir
response = Omise.Charges.create(
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

## Documentation

 * http://hexdocs.pm/omise/
