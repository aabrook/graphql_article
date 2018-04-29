defmodule EventTracker.Schema do
  use Absinthe.Schema
  use Absinthe.Schema.Notation

  import Ecto.Query
  alias EventTracker.{Event, Participant, Repo}

  import_types(EventTracker.Types)

  query do
    field :events, list_of(:event) do
      resolve(fn _, _ -> list(Event) end)
    end

    field :event, :event do
      arg(:id, non_null(:id))
      resolve(fn _, %{id: id}, _ -> get(Event, id) end)
    end

    field :participants, list_of(:participant) do
      arg(:event_id, non_null(:id))
      resolve(fn %{event_id: id}, _ -> list(Participant, event_id: id) end)
    end

    field :participant, :participant do
      arg(:id, non_null(:id))
      resolve(fn %{id: id}, _ -> get(Participant, id) end)
    end
  end

  mutation do
    field :create_event, :event do
      arg :name, non_null(:string)
      arg :activity_type, non_null(list_of(:string))
      arg :registration_open, :datetime

      resolve &create_event/3
    end
  end

  defp create_event(_parent, args, _context) do
    Event.changeset(%Event{}, args)
    |> Repo.insert
  end

  defp list(Event) do
    events = Event |> Repo.all()

    {:ok, events}
  end

  defp list(Participant, event_id: event_id) do
    participants =
      from(
        p in Participant,
        where: p.event_id == ^event_id,
        order_by: :inserted_at
      )
      |> Repo.all()

    case participants do
      nil -> {:error, "Not found"}
      participants -> {:ok, participants}
    end
  end

  defp get(Event, id) do
    case Repo.get(Event, id) do
      nil -> {:error, "Not found"}
      event -> {:ok, event}
    end
  end

  defp get(Participant, id) do
    case Repo.get(Participant, id) do
      nil -> {:error, "Not found"}
      participant -> {:ok, participant}
    end
  end
end
