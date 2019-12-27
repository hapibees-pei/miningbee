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
    query = from sensor in Sensor,
      where: sensor.apiary_id == ^gateway_id

    Repo.all(query)
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
    Timex.shift(date, minutes: -59)
  end

  def stats_time_frame(date, "hour") do
    Timex.shift(date, hours: -23)
  end

  def stats_time_frame(date, "day") do
    Timex.shift(date, weeks: -1)
  end

  def stats_group_filter(%{"group" => "minute"} = _params) do
    "minute"
  end

  def stats_group_filter(%{"group" => "hour"} = _params) do
    "hour"
  end

  def stats_group_filter(%{"group" => "day"} = _params) do
    "day"
  end

  def stats_group_filter(_params) do
    "hour"
  end

  def params_filter(%{"hive_id" => hive_id, "apiary_id" => apiary_id} = _params) do
    {hive_id, apiary_id}
  end

  def params_filter(_params) do
    {:error, :bad_request}
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
    (interval ++ data)
    |> Enum.group_by(fn tuple -> get_field(tuple, field) end)
    |> Enum.map(fn {_, v} -> averagee(v) end)
    |> Enum.uniq_by(fn tuple -> get_field(tuple, field) end)
    |> Enum.sort_by(& &1, &sort_date/2)
  end

  defp get_field({date, _}, "minute") do
    date.minute
  end

  defp get_field({date, _}, "hour") do
    date.hour
  end

  defp get_field({date, _}, "day") do
    date.day
  end

  defp sort_date({date1, _avg1}, {date2, _avg2}) do
    Timex.before?(date1, date2)
  end

  defp averagee(v) do
    v =
      if length(v) > 1 do
        tl(v)
      else
        v
      end

    {elem(hd(v), 0),
     Enum.reduce(v, 0, fn {_date, value}, acc -> value + acc end) / length(v)}
  end

  def valid_stat_query?(query) do
    valid_querys = [
      "minute",
      "hour",
      "day"
    ]

    Enum.member?(valid_querys, query)
  end
end
