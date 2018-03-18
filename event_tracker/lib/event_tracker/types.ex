defmodule EventTracker.Types do
  use Absinthe.Schema.Notation

  object :event do
    field(:id, :id)
    field(:name, :string)
    field(:activity_type, list_of(:string))
  end

end

