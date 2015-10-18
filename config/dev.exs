use Mix.Config

config :omise,
  secret_key: System.get_env("SECRET_KEY"),
  public_key: System.get_env("PUBLIC_KEY")
