# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :omise,
  public_key: System.get_env("OMISE_PUBLIC_KEY"),
  secret_key: System.get_env("OMISE_SECRET_KEY")
