defmodule Miningbee.Repo.Migrations.CreateSensors do
  use Ecto.Migration

  def change do
    create table(:sensors, primary_key: false) do
      add :hive_id, :integer, null: false, primary_key: true

      add :apiary_id, references(:gateways, column: :apiary_id, type: :uuid),
        null: false,
        primary_key: true

      add :topic, :string

      timestamps()
    end

    create unique_index(:sensors, [:apiary_id, :hive_id], name: :apiary_hive_index)
  end
end
