defmodule Miningbee.Apiaries.Sensor do
  use Ecto.Schema
  import Ecto.Changeset

  alias Miningbee.Apiaries.Gateway

  #  @derive {Phoenix.Param, key: :hive_id}
  @primary_key false
  schema "sensors" do
    field :hive_id, :integer, primary_key: true

    field :topic, :string

    belongs_to :gateway, Gateway,
      foreign_key: :apiary_id,
      references: :apiary_id,
      type: :binary_id,
      primary_key: true

    timestamps()
  end

  # maybe check/validate topic format
  def changeset(sensor, attrs) do
    sensor
    |> cast(attrs, [:hive_id, :topic, :apiary_id])
    |> unique_constraint(:apiary_hive_index,
      name: :apiary_hive_index,
      message: "An hive with that exists for that apiary"
    )
    |> validate_required([:topic, :apiary_id, :hive_id])
  end

  def update_changeset(sensor, attrs) do
    sensor
    |> cast(attrs, [:topic])
    |> validate_required([:topic])
  end
end
