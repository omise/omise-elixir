# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the namespace used by Phoenix generators
config :got,
  app_namespace: GOT

# Configures the endpoint
config :got, GOT.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "MJ+1hKOVxCwdXVo5As9uFNXUwy/IcqjcD5leIYndZuXPCxPqkEhE3+mzhnZLEcek",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: GOT.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :omise,
  secret_key: System.get_env("OMISE_SECRET_KEY"),
  public_key: System.get_env("OMISE_PUBLIC_KEY")

# Omise Api
config :got,
  omise_api: GOT.OmiseLive

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
