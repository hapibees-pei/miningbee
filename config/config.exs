# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :miningbee,
  ecto_repos: [Miningbee.Repo]

# Configures the endpoint
config :miningbee, MiningbeeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "cqt+Dbz43Limn0I0sWmIovbz6aGXepZmOKDz9x0w+1XIvEuo0XfxSziPKjIF5FLC",
  render_errors: [view: MiningbeeWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Miningbee.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

config :miningbee, Miningbee.Mqtt.Connection,
  client_id: "mining",
  host: "127.0.0.1",
  port: 1883,
  user_name: "guest",
  password: "guest",
  keep_alive: 600,
  subscriptions: "#"

import_config "#{Mix.env()}.exs"
