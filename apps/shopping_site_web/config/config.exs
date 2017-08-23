# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :shopping_site_web, ShoppingSiteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WdiXmz1G8iulfBiaONVGD8taBhDM2J5ROBSNNPjQcadz9KegpcfRFXOy9OnkQqXA",
  render_errors: [view: ShoppingSiteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShoppingSiteWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
