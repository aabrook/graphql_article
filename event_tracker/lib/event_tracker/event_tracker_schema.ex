defmodule EventTracker.Schema do
  use Absinthe.Schema
  use Absinthe.Schema.Notation

  import Ecto.Query
  alias EventTracker.Repo

  alias EventTracker.Event

  object :event do
    field :name, :string
    field :activity_type, list_of(:string)
  end

  query do
    field :events, list_of(:event) do
      resolve fn _, _ -> list(Event) end
    end
  end

  defp list(Event) do
    events = Event |> Repo.all

    {:ok, events}
  end
end
