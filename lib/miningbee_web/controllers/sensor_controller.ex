defmodule MiningbeeWeb.SensorController do
  use MiningbeeWeb, :controller

  alias Miningbee.Models
  alias Miningbee.Models.Sensor

  action_fallback MiningbeeWeb.FallbackController

  def index(conn, _params) do
    sensors = Models.list_sensors()
    render(conn, "index.json", sensors: sensors)
  end

  def create(conn, %{"sensor" => sensor_params}) do
    with {:ok, %Sensor{} = sensor} <- Models.create_sensor(sensor_params) do
      conn
      |> put_status(:created)
      |> render("show.json", sensor: sensor)
    end
  end

  def show(conn, %{"id" => id}) do
    sensor = Models.get_sensor!(id)
    render(conn, "show.json", sensor: sensor)
  end

  def update(conn, %{"id" => id, "sensor" => sensor_params}) do
    sensor = Models.get_sensor!(id)

    with {:ok, %Sensor{} = sensor} <- Models.update_sensor(sensor, sensor_params) do
      render(conn, "show.json", sensor: sensor)
    end
  end

  def delete(conn, %{"id" => id}) do
    sensor = Models.get_sensor!(id)

    with {:ok, %Sensor{}} <- Models.delete_sensor(sensor) do
      send_resp(conn, :no_content, "")
    end
  end
end
