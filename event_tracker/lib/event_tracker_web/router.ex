defmodule EventTrackerWeb.Router do
  use EventTrackerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  forward("/api", Absinthe.Plug, schema: EventTracker.Schema)
end
