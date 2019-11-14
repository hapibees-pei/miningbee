defmodule Miningbee.Apiaries.Gateway do
  use Ecto.Schema
  import Ecto.Changeset

  alias Miningbee.Apiaries.Sensor

  @primary_key {:apiary_id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :apiary_id}
  schema "gateways" do
    field :topic, :string

    has_many :sensors, Sensor, foreign_key: :hive_id, references: :apiary_id, on_replace: :delete, on_delete: :delete_all

    timestamps()
  end

  # maybe check/validate topic format
  def changeset(gateway, attrs) do
    gateway
    |> cast(attrs, [:topic])
    |> validate_required([:topic])
  end

  def update_changeset(gateway, attrs) do
    gateway
    |> cast(attrs, [:topic])
    |> validate_required([:topic])
  end

end
