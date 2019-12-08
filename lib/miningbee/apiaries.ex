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
  def list_sensors(gateway_id) do
    Repo.get_by!(Sensor, apiary_id: gateway_id)
  end

  def get_sensor!(apiary_id, hive_id) do
    Repo.get_by(Sensor, apiary_id: apiary_id, hive_id: hive_id)
  end

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

  def stats_date_filter(%{"date" => date} = _params) do
    # type used by JS (check if same as rails)
    with {:ok, parsed_date} <- Timex.parse!(date, "{RFC3339z}") do
      parsed_date
    end
  end

  def stats_date_filter(_params) do
    Timex.now()
  end

  def stats_time_frame(date, "minute") do
    Timex.shift(date, hours: -1)
  end

  def stats_time_frame(date, "hour") do
    Timex.shift(date, days: -1)
  end

  def stats_time_frame(date, "day") do
    Timex.shift(date, weeks: -1)
  end

  def stats_group_filter(%{"group" => group} = params) do
    group
  end

  def stats_group_filter(params) do
    "hour"
  end

  def hive_id_filter(params) do
    if Map.has_key?(params, "hive_id") do
      Map.fetch(params, "hive_id")
    else
      {:error, :bad_request}
    end
  end

  def stats_data_padding(min_date, max_date, "minute") do
    Timex.Interval.new(from: min_date, until: max_date, right_open: false)
    |> Timex.Interval.with_step(minutes: 1)
    |> Enum.map(fn x ->
      {x, 0}
    end)
  end

  def stats_data_padding(min_date, max_date, "hour") do
    Timex.Interval.new(from: min_date, until: max_date, right_open: false)
    |> Timex.Interval.with_step(hours: 1)
    |> Enum.map(fn x ->
      {x, 0}
    end)
  end

  def stats_data_padding(min_date, max_date, "day") do
    Timex.Interval.new(from: min_date, until: max_date, right_open: false)
    |> Timex.Interval.with_step(days: 1)
    |> Enum.map(fn x ->
      {x, 0}
    end)
  end

  def merge_empty_data(interval, data, field) do
    (data ++ interval)
    |> Enum.group_by(fn tuple -> get_field(tuple, field) end)
    |> Enum.map(fn {_, v} -> averagee(v) end)
    |> Enum.uniq_by(fn tuple -> get_field(tuple, field) end)
    |> Enum.sort_by(fn {date, avg} -> {date, avg} end)
  end

  def get_field({date, _}, "minute") do
    date.minute
  end

  def get_field({date, _}, "hour") do
    date.hour
  end

  def get_field({date, _}, "day") do
    date.day
  end

  def averagee(v),
    do:
      {elem(hd(v), 0),
       Enum.reduce(v, 0, fn {date, value}, acc -> value + acc end) / length(v)}

  def valid_stat_query?(query) do
    valid_querys = [
      "minute",
      "hour",
      "day"
    ]

    Enum.member?(valid_querys, query)
  end
end
