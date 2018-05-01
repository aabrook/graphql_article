defmodule EventTrackerWeb.Router do
  use EventTrackerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  forward("/api", Absinthe.Plug, schema: EventTracker.Schema)

  if Mix.env() == :dev do
    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: EventTracker.Schema)
  end
end
