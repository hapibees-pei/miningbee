defmodule Miningbee.Apiaries.Sensor do
  use Ecto.Schema
  import Ecto.Changeset

  alias Miningbee.Apiaries.Gateway

  @primary_key {:hive_id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :hive_id}
  schema "sensors" do
    field :topic, :string

    belongs_to :gateway, Gateway,
      foreign_key: :apiary_id,
      references: :apiary_id,
      type: :binary_id

    timestamps()
  end

  # maybe check/validate topic format
  def changeset(sensor, attrs) do
    sensor
    |> cast(attrs, [:topic, :apiary_id])
    |> validate_required([:topic, :apiary_id])
  end

  def update_changeset(sensor, attrs) do
    sensor
    |> cast(attrs, [:topic])
    |> validate_required([:topic])
  end
end
