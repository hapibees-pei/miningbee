defmodule MiningbeeWeb.SensorController do
  use MiningbeeWeb, :controller

  alias Miningbee.Apiaries
  alias Miningbee.Apiaries.Sensor

  action_fallback MiningbeeWeb.FallbackController

  def index(conn, _params) do
    sensors = Apiaries.list_sensors()
    render(conn, "index.json", sensors: sensors)
  end

  def show(conn, %{"gateway_id" => gateway_id, "hive_id" => hive_id}) do
    sensor = Apiaries.get_sensor!(gateway_id, hive_id)
    render(conn, "show.json", sensor: sensor)
  end
end
