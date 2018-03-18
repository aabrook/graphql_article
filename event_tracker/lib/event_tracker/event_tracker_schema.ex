defmodule EventTracker.Schema do
  use Absinthe.Schema
  use Absinthe.Schema.Notation

  object :event do
    field :name, :string
    field :activity_type, list_of(:string)
  end

  query do
    field :events, list_of(:event) do
      resolve fn _, _ -> {:ok, [%EventTracker.Event{ activity_type: [], name: "Yo" }]} end
    end
  end
end
