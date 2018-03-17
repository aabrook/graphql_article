defmodule EventTracker.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :registration_open, :utc_datetime
      add :registration_close, :utc_datetime
      add :fundraise_starts, :utc_datetime
      add :fundraise_ends, :utc_datetime
      add :participation_starts, :utc_datetime
      add :participation_ends, :utc_datetime
      add :name, :string
      add :activity_type, {:array, :string}

      timestamps()
    end

  end
end
