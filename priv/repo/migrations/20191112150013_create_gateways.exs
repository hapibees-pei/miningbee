defmodule Miningbee.Repo.Migrations.CreateGateways do
  use Ecto.Migration

  def change do
    create table(:gateways) do
      add :apiary_id, :uuid, primary_key: true
      add :topic, :string

      timestamps()
    end

    create unique_index(:gateways, [:apiary_id])
  end
end
