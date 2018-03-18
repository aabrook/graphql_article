defmodule EventTracker.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: EventTracker.Repo

  object :event do
    field(:id, :id)
    field(:name, :string)
    field(:activity_type, list_of(:string))
    field(:participants, list_of(:participant), resolve: assoc(:participants))
  end

  object :participant do
    field(:id, :id)
    field(:name, :string)

    field(:event, :event, resolve: assoc(:event))
  end

end

