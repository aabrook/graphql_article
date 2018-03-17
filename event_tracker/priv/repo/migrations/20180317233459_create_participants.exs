defmodule EventTracker.Repo.Migrations.CreateParticipants do
  use Ecto.Migration

  def change do
    create table(:participants, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :event_id, references(:events, on_delete: :nothing, type: :uuid)

      timestamps()
    end

    create index(:participants, [:event_id])
  end
end
