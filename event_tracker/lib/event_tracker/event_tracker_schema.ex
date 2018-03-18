defmodule EventTracker.Schema do
  use Absinthe.Schema
  use Absinthe.Schema.Notation

  import Ecto.Query
  alias EventTracker.Repo

  alias EventTracker.Event

  object :event do
    field(:id, :id)
    field(:name, :string)
    field(:activity_type, list_of(:string))
  end

  query do
    field :events, list_of(:event) do
      resolve(fn _, _ -> list(Event) end)
    end

    field :event, :event do
      arg(:id, non_null(:id))
      resolve(fn _, %{id: id}, _ -> get(Event, id) end)
    end
  end

  defp list(Event) do
    events = Event |> Repo.all()

    {:ok, events}
  end

  defp get(Event, id) do
    case Repo.get(Event, id) do
      nil -> {:error, "Not found"}
      event -> {:ok, event}
    end
  end
end
