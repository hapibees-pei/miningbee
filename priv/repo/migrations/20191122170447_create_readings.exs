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

      add :hive_id, references(:sensors, column: :hive_id, type: :uuid)

      timestamps()
    end
  end
end
