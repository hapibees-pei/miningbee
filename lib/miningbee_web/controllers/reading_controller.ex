defmodule MiningbeeWeb.ReadingController do
  use MiningbeeWeb, :controller

  alias Miningbee.Statistics

  action_fallback MiningbeeWeb.FallbackController

  def show(conn, params) do
    with {:ok, query} <- Map.fetch(params, "query") do
      case query do
        "light" ->
          light_stat(conn, params)

        "pressure" ->
          pressure_stat(conn, params)

        "noise" ->
          noise_stat(conn, params)

        "temperature" ->
          temperature_stat(conn, params)

        "humidity" ->
          humidity_stat(conn, params)

        "accelerometer" ->
          accelerometer_stat(conn, params)

        _ ->
          {:error, :bad_request}
      end
    end
  end

  defp light_stat(conn, params) do
    with readings <- Statistics.light_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

  defp pressure_stat(conn, params) do
    with readings <- Statistics.pressure_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

  defp noise_stat(conn, params) do
    with readings <- Statistics.noise_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

  defp temperature_stat(conn, params) do
    with readings <- Statistics.temperature_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

  defp humidity_stat(conn, params) do
    with readings <- Statistics.humidity_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

  defp accelerometer_stat(conn, params) do
    with readings <- Statistics.accelerometer_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end
end
