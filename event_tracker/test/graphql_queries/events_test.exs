defmodule EventTrackerWeb.GraphQL.EventsTest do
  use EventTrackerWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  import EventTrackerWeb.Router.Helpers

  test "can list all events", %{conn: conn} do
    query = """
    {
      events {
        name
      }
    }
    """
    %{"data" => result} = conn
      |> Plug.Conn.put_req_header("content-type", "application/graphql")
      |> get("/api", query)
      |> Map.get(:resp_body)
      |> Poison.decode!()

    assert result == %{
      "events" => [
        %{
          "name" => "Yo"
        }
      ]
    }
  end
end
