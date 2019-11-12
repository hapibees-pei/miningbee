defmodule Miningbee.Models.Gateway do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:apiary_id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :apiary_id}
  schema "gateways" do
    field :topic, :string

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
    |> validate_required(attrs, [:topic])
  end

end
