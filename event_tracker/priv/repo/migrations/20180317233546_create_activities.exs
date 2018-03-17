defmodule EventTracker.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :completed_at, :utc_datetime
      add :distance, :integer
      add :participant_id, references(:participants, on_delete: :nothing, type: :uuid)

      timestamps()
    end

    create index(:activities, [:participant_id])
  end
end
