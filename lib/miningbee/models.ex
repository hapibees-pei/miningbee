defmodule Miningbee.Models do

  import Ecto.Query, warn: false
  alias Miningbee.Repo

  alias Miningbee.Models.Gateway
  alias Miningbee.Models.Sensor

  ## GATEWAYS
  def list_gateways do
    Repo.all(Gateway)
  end

  def get_gateway!(id), do: Repo.get!(Gateway, id)

  def create_gateway(attrs \\ %{}) do
    %Gateway{}
    |> Gateway.changeset(attrs)
    |> Repo.insert()
  end

  def update_gateway(%Gateway{} = gateway, attrs) do
    gateway
    |> Gateway.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_gateway(%Gateway{} = gateway) do
    Repo.delete(gateway)
  end

  ## SENSORS
  def list_sensors do
    Repo.all(Sensor)
  end

  def get_sensor!(id), do: Repo.get!(Sensor, id)

  def create_sensor(attrs \\ %{}) do
    %Sensor{}
    |> Sensor.changeset(attrs)
    |> Repo.insert()
  end

  def update_sensor(%Sensor{} = sensor, attrs) do
    sensor
    |> Sensor.changeset(attrs)
    |> Repo.update()
  end

  def delete_sensor(%Sensor{} = sensor) do
    Repo.delete(sensor)
  end

end
