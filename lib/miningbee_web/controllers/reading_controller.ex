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

        "sound" ->
          sound_stat(conn, params)

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
    with {:ok, readings} <- Statistics.light_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

  defp pressure_stat(conn, params) do
    with {:ok, readings} <- Statistics.pressure_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

  defp sound_stat(conn, params) do
    with {:ok, readings} <- Statistics.sound_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

  defp temperature_stat(conn, params) do
    with {:ok, readings} <- Statistics.temperature_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

  defp humidity_stat(conn, params) do
    with {:ok, readings} <- Statistics.humidity_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

  defp accelerometer_stat(conn, params) do
    with {:ok, readings} <- Statistics.accelerometer_stat(params) do
      conn
      |> render("show.json", reading: readings)
    end
  end

end
