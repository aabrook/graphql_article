defmodule EventTrackerWeb.GraphQL.EventsTest do
  use EventTrackerWeb.ConnCase, async: true

  alias EventTracker.{Event, Participant}
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
                 %{"name" => participant.name}
               ]
             }
           } == result
  end

  test "can get an event, with participants, with event details", %{conn: conn} do
    event = Factory.insert(Event)
    jo = Factory.insert(Participant, event: event)
    not_jo = Factory.insert(Participant, event: event, name: "Not Jo")

    query = """
    {
      event(id: "#{event.id}") {
        name
        activity_type
        participants {
          name
          event {
            name
            activity_type
          }
        }
      }
    }
    """

    event = %{
      "name" => event.name,
      "activity_type" => event.activity_type
    }

    expected_event = %{
      "event" => event
    }

    participants = [
      %{
        "name" => jo.name,
        "event" => event
      },
      %{
        "name" => not_jo.name,
        "event" => event
      }
    ]

    expected_participants =
      participants
      |> Enum.map(&Map.put(&1, "event", expected_event))

    expected_result = put_in(expected_event, ["event", "participants"], expected_participants)

    %{"data" => result} =
      conn
      |> Plug.Conn.put_req_header("content-type", "application/graphql")
      |> get("/api", query)
      |> Map.get(:resp_body)
      |> Poison.decode!()

    assert expected_result = result
  end

  test "can create a new event", %{conn: conn} do
    query = """
    mutation CreateEvent {
      create_event (name: "In memory of Jo", activity_type: ["walk", "run"], registration_open: "2018-05-02T00:00:00Z") {
        id
        name
        activity_type
        registration_open
      }
    }
    """

    %{"data" => result} =
      conn
      |> Plug.Conn.put_req_header("content-type", "application/graphql")
      |> post("/api", query)
      |> Map.get(:resp_body)
      |> Poison.decode!()

    assert %{
             "create_event" => %{
               "id" => _,
               "name" => "In memory of Jo",
               "activity_type" => ["walk", "run"],
               "registration_open" => "2018-05-02T00:00:00Z"
             }
           } = result
  end

  test "ensure name and activity_type are required", %{conn: conn} do
    query = """
    mutation CreateEvent {
      create_event (registration_open: "2018-05-02T00:00:00Z") {
        id
        name
        activity_type
      }
    }
    """

    %{"errors" => result} =
      conn
      |> Plug.Conn.put_req_header("content-type", "application/graphql")
      |> post("/api", query)
      |> Map.get(:resp_body)
      |> Poison.decode!()

    assert [
             %{"message" => _},
             %{"message" => _}
           ] = result
  end
end
