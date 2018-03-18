defmodule EventTracker.Participant do
  use Ecto.Schema
  import Ecto.Changeset
  alias EventTracker.Event

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "participants" do
    field(:name, :string)
    # field(:event_id, :binary_id)

    belongs_to :event, Event

    timestamps()
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
