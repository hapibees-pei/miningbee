defmodule Miningbee.Apiaries.Gateway do
  use Ecto.Schema
  import Ecto.Changeset

  alias Miningbee.Apiaries.Sensor
  alias Miningbee.Apiaries.Reading

  @primary_key {:apiary_id, :binary_id, autogenerate: false}
  # @derive {Phoenix.Param, key: :apiary_id}
  schema "gateways" do
    field :topic, :string

    has_many :sensors, Sensor,
      foreign_key: :apiary_id,
      references: :apiary_id,
      on_replace: :delete,
      on_delete: :delete_all

    has_many :readings, Reading,
      foreign_key: :apiary_id,
      references: :apiary_id,
      on_replace: :delete,
      on_delete: :delete_all

    timestamps()
  end

  # maybe check/validate topic format
  def changeset(gateway, attrs) do
    gateway
    |> cast(attrs, [:apiary_id, :topic])
    |> validate_required([:apiary_id, :topic])
  end

  def update_changeset(gateway, attrs) do
    gateway
    |> cast(attrs, [:topic])
    |> validate_required([:topic])
  end
end
