defmodule EventTrackerWeb.GraphQL.EventsTest do
  use EventTrackerWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  import EventTrackerWeb.Router.Helpers

  alias EventTracker.{Event, Participant, Repo}
  alias EventTracker.Test.Factory

  test "can list all events", %{conn: conn} do
    query = """
    {
      events {
        name
        activity_type
      }
    }
    """

    event = Factory.insert(Event)
    Factory.insert(Participant, %{event: event})

    %{"data" => result} =
      conn
      |> Plug.Conn.put_req_header("content-type", "application/graphql")
      |> get("/api", query)
      |> Map.get(:resp_body)
      |> Poison.decode!()

    assert result == %{
             "events" => [
               %{
                 "name" => event.name,
                 "activity_type" => event.activity_type
               }
             ]
           }
  end

  test "can get a single event", %{conn: conn} do
    event = Factory.insert(Event)

    query = """
    {
      event(id: "#{event.id}") {
        name
        activity_type
      }
    }
    """

    %{"data" => result} =
      conn
      |> Plug.Conn.put_req_header("content-type", "application/graphql")
      |> get("/api", query)
      |> Map.get(:resp_body)
      |> Poison.decode!()

    assert %{
             "event" => %{
               "name" => event.name,
               "activity_type" => event.activity_type
             }
           } == result
  end

  test "can get a single event with participants", %{conn: conn} do
    event = Factory.insert(Event)
    participant = Factory.insert(Participant, %{event: event})

    query = """
    {
      event(id: "#{event.id}") {
        name
        activity_type
        participants {
          name
        }
      }
    }
    """

    %{"data" => result} =
      conn
      |> Plug.Conn.put_req_header("content-type", "application/graphql")
      |> get("/api", query)
      |> Map.get(:resp_body)
      |> Poison.decode!()

    assert %{
             "event" => %{
               "name" => event.name,
               "activity_type" => event.activity_type,
               "participants" => [
                 %{ "name" => participant.name }
               ]
             }
           } == result
  end
end
