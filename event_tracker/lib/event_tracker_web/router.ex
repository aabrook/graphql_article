defmodule EventTrackerWeb.Router do
  use EventTrackerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EventTrackerWeb do
    pipe_through :api
  end
end
