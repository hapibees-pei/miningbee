defmodule Miningbee.Apiaries do
  import Ecto.Query, warn: false
  alias Miningbee.Repo

  alias Miningbee.Apiaries.{Gateway, Reading, Sensor}

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

  def list_readings do
    Repo.all(Reading)
  end

  def get_reading!(id), do: Repo.get!(Reading, id)

  # use Statistics to get individual reading params

  def create_reading(attrs \\ %{}) do
    %Reading{}
    |> Reading.changeset(attrs)
    |> Repo.insert()
  end

  def delete_reading(%Reading{} = reading) do
    Repo.delete(reading)
  end
end
