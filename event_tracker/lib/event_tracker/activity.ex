defmodule EventTracker.Activity do
  use Ecto.Schema
  import Ecto.Changeset


  schema "activities" do
    field :completed_at, :utc_datetime
    field :distance, :integer
    field :type, :string
    field :participant_id, :id

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:type, :completed_at, :distance])
    |> validate_required([:type, :completed_at, :distance])
  end
end
