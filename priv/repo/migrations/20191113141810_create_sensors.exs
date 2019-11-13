defmodule Miningbee.Repo.Migrations.CreateSensors do
  use Ecto.Migration

  def change do
    create table(:sensors, primary_key: false) do
      add :hive_id, :uuid, primary_key: true
      add :topic, :string

      add :apiary_id, references(:gateways, column: :apiary_id, type: :uuid)

      timestamps()
    end

    create unique_index(:sensors, [:hive_id])
  end
end
