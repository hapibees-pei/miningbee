defmodule Miningbee.Repo.Migrations.CreateReadings do
  use Ecto.Migration

  def change do
    create table(:readings) do
      add :temperature, :float
      add :pressure, :float
      add :light, :float
      add :noise, :float
      add :humidity, :float
      add :accelerometer, :float
      add :date, :utc_datetime

      add :apiary_id, references(:gateways, column: :apiary_id, type: :uuid), null: false

      add :hive_id, :integer, null: false

      timestamps()
    end

    create index(:readings, [:apiary_id, :hive_id], name: :apiary_hive_reading_index)
  end
end
