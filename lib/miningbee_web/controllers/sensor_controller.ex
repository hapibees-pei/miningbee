defmodule MiningbeeWeb.SensorController do
  use MiningbeeWeb, :controller

  alias Miningbee.Apiaries
  alias Miningbee.Apiaries.Sensor

  action_fallback MiningbeeWeb.FallbackController

  def index(conn, _params) do
    sensors = Apiaries.list_sensors()
    render(conn, "index.json", sensors: sensors)
  end

  def create(conn, %{"sensor" => sensor_params}) do
    with {:ok, %Sensor{} = sensor} <- Apiaries.create_sensor(sensor_params) do
      conn
      |> put_status(:created)
      |> render("show.json", sensor: sensor)
    end
  end

  def show(conn, %{"id" => id}) do
    sensor = Apiaries.get_sensor!(id)
    render(conn, "show.json", sensor: sensor)
  end

  def update(conn, %{"id" => id, "sensor" => sensor_params}) do
    sensor = Apiaries.get_sensor!(id)

    with {:ok, %Sensor{} = sensor} <-
           Apiaries.update_sensor(sensor, sensor_params) do
      render(conn, "show.json", sensor: sensor)
    end
  end

  def delete(conn, %{"id" => id}) do
    sensor = Apiaries.get_sensor!(id)

    with {:ok, %Sensor{}} <- Apiaries.delete_sensor(sensor) do
      send_resp(conn, :no_content, "")
    end
  end
end
