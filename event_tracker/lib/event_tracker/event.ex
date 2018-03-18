defmodule EventTracker.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :activity_type, {:array, :string}
    field :fundraise_ends, :utc_datetime
    field :fundraise_starts, :utc_datetime
    field :name, :string
    field :participation_ends, :utc_datetime
    field :participation_starts, :utc_datetime
    field :registration_close, :utc_datetime
    field :registration_open, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:registration_open, :registration_close, :fundraise_starts, :fundraise_ends, :participation_starts, :participation_ends, :name, :activity_type])
    |> validate_required([:name])
  end
end
