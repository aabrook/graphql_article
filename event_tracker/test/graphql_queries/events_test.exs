defmodule EventTrackerWeb.GraphQL.EventsTest do
  use EventTrackerWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  import EventTrackerWeb.Router.Helpers

  alias EventTracker.Repo
  alias EventTracker.Event

  test "can list all events", %{conn: conn} do
    query = """
    {
      events {
        name,
        activity_type
      }
    }
    """

    {:ok, _} = %Event{} |> Event.changeset(%{name: "Yo", activity_type: ["running", "riding"]}) |> Repo.insert()

    %{"data" => result} = conn
      |> Plug.Conn.put_req_header("content-type", "application/graphql")
      |> get("/api", query)
      |> Map.get(:resp_body)
      |> Poison.decode!()

    assert result == %{
      "events" => [
        %{
          "name" => "Yo",
          "activity_type" => [
            "running",
            "riding"
          ]
        }
      ]
    }
  end
end
