defmodule MiningbeeWeb.StatisticsController do
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
        _ ->
          {:error, :bad_request}
      end
    end
  end

  defp light_stat(conn, params) do
    with {:ok, stats} <- Statistics.light_stat(params) do
      conn
      |> render("show.json", statistic: stats)
    end
  end

  defp pressure_stat(conn, params) do
    with {:ok, stats} <- Statistics.pressure_stat(params) do
      conn
      |> render("show.json", statistic: stats)
    end
  end

  defp sound_stat(conn, params) do
    with {:ok, stats} <- Statistics.sound_stat(params) do
      conn
      |> render("show.json", statistic: stats)
    end
  end

  defp temperature_stat(conn, params) do
    with {:ok, stats} <- Statistics.temperature_stat(params) do
      conn
      |> render("show.json", statistic: stats)
    end
  end

end
