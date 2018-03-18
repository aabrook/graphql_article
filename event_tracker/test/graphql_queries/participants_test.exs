defmodule EventTrackerWeb.GraphQL.ParticipantsTest do
  use EventTrackerWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  import EventTrackerWeb.Router.Helpers
  import Ecto.Query


  alias EventTracker.{Event, Participant, Repo}
  alias EventTracker.Test.Factory

  test "can list all participants of an event", %{conn: conn} do
    event = Factory.insert(Event)
    participant = Factory.insert(Participant, %{event: event})

    query = """
    {
      participants (event_id: "#{event.id}"){
        name
      }
    }
    """

    %{"data" => result} =
      conn
      |> Plug.Conn.put_req_header("content-type", "application/graphql")
      |> get("/api", query)
      |> Map.get(:resp_body)
      |> Poison.decode!()

    assert result == %{
             "participants" => [
               %{
                 "name" => participant.name,
               }
             ]
           }
  end

  test "can get a single participant", %{conn: conn} do
    event = Factory.insert(Event)
    participant = Factory.insert(Participant, %{event: event})

    query = """
    {
      participant (id: "#{participant.id}") {
        name
        event {
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
             "participant" => %{
               "name" => participant.name,
               "event" => %{
                 "name" => event.name
               }
             }
           } == result
  end
end
