defmodule MiningbeeWeb.SensorController do
  use MiningbeeWeb, :controller

  alias Miningbee.Apiaries

  action_fallback MiningbeeWeb.FallbackController

  def index(conn, %{"gateway_id" => gateway_id} = _params) do
    case Ecto.UUID.dump(gateway_id) do
      :error ->
        {:error, :bad_request}
      {:ok, _gateway} ->
        case Apiaries.list_sensors(gateway_id) do
          [] ->
            {:error, :not_found}
          sensors ->
            render(conn, "index.json", sensors: sensors)
        end
    end
  end

  def index(conn, _params) do
    render(conn, "400.json", %{})
  end

  def show(conn, %{"gateway_id" => gateway_id, "hive_id" => hive_id}) do
    sensor = Apiaries.get_sensor!(gateway_id, hive_id)
    render(conn, "show.json", sensor: sensor)
  end
end
