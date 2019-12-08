defmodule Miningbee.Apiaries.Reading do
  use Ecto.Schema
  import Ecto.Changeset

  schema "readings" do
    field :accelerometer, :float
    field :humidity, :float
    field :light, :float
    field :noise, :float
    field :pressure, :float
    field :temperature, :float
    field :date, :utc_datetime

    belongs_to :sensor, Sensor,
      foreign_key: :apiary_id,
      references: :apiary_id,
      type: :binary_id

    timestamps()
  end

  def changeset(reading, attrs) do
    reading
    |> cast(attrs, [
      :apiary_id,
      :temperature,
      :pressure,
      :light,
      :noise,
      :humidity,
      :accelerometer,
      :date
    ])
    |> validate_required([
      :apiary_id,
      :temperature,
      :pressure,
      :light,
      :noise,
      :humidity,
      :accelerometer,
      :date
    ])
  end
end
