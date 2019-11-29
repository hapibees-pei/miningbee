defmodule Miningbee.Statistics do
  import Ecto.Query, warn: false
  alias Miningbee.Repo
  alias Miningbee.Apiaries
  alias Miningbee.Apiaries.Reading

  # LIGHT
  def light_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    with {:ok, hive_id} <- Apiaries.hive_id_filter(params) do
      case group do
        "minute" -> {:ok, light_minute(date, time_frame, hive_id)}
        "hour" -> {:ok, light_hour(date, time_frame, hive_id)}
        "day" -> {:ok, light_day(date, time_frame, hive_id)}
      end
    end
  end

  defp light_minute(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('minute', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('minute', ?)", reading.date),
          avg(reading.light)}

    Repo.all(query)
  end

  defp light_hour(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('hour', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('hour', ?)", reading.date),
          avg(reading.light)}

    Repo.all(query)
  end

  defp light_day(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('day', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('day', ?)", reading.date),
          avg(reading.light)}

    Repo.all(query)
  end

  # PRESSURE
  def pressure_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    with {:ok, hive_id} <- Apiaries.hive_id_filter(params) do
      case group do
        "minute" -> {:ok, pressure_minute(date, time_frame, hive_id)}
        "hour" -> {:ok, pressure_hour(date, time_frame, hive_id)}
        "day" -> {:ok, pressure_day(date, time_frame, hive_id)}
      end
    end
  end

  defp pressure_minute(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('minute', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('minute', ?)", reading.date),
          avg(reading.pressure)}

    Repo.all(query)
  end

  defp pressure_hour(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('hour', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('hour', ?)", reading.date),
          avg(reading.pressure)}

    Repo.all(query)
  end

  defp pressure_day(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('day', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('day', ?)", reading.date),
          avg(reading.pressure)}

    Repo.all(query)
  end

  # NOISE
  def noise_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    with {:ok, hive_id} <- Apiaries.hive_id_filter(params) do
      case group do
        "minute" -> {:ok, noise_minute(date, time_frame, hive_id)}
        "hour" -> {:ok, noise_hour(date, time_frame, hive_id)}
        "day" -> {:ok, noise_day(date, time_frame, hive_id)}
      end
    end
  end

  defp noise_minute(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('minute', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('minute', ?)", reading.date),
          avg(reading.noise)}

    Repo.all(query)
  end

  defp noise_hour(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('hour', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('hour', ?)", reading.date),
          avg(reading.noise)}

    Repo.all(query)
  end

  defp noise_day(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('day', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('day', ?)", reading.date),
          avg(reading.noise)}

    Repo.all(query)
  end

  # TEMPERATURE
  def temperature_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    with {:ok, hive_id} <- Apiaries.hive_id_filter(params) do
      case group do
        "minute" -> {:ok, temperature_minute(date, time_frame, hive_id)}
        "hour" -> {:ok, temperature_hour(date, time_frame, hive_id)}
        "day" -> {:ok, temperature_day(date, time_frame, hive_id)}
      end
    end
  end

  defp temperature_minute(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('minute', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('minute', ?)", reading.date),
          avg(reading.temperature)}

    Repo.all(query)
  end

  defp temperature_hour(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('hour', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('hour', ?)", reading.date),
          avg(reading.temperature)}

    Repo.all(query)
  end

  defp temperature_day(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('day', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('day', ?)", reading.date),
          avg(reading.temperature)}

    Repo.all(query)
  end

  # HUMIDITY
  def humidity_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    with {:ok, hive_id} <- Apiaries.hive_id_filter(params) do
      case group do
        "minute" -> {:ok, humidity_minute(date, time_frame, hive_id)}
        "hour" -> {:ok, humidity_hour(date, time_frame, hive_id)}
        "day" -> {:ok, humidity_day(date, time_frame, hive_id)}
      end
    end
  end

  defp humidity_minute(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('minute', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('minute', ?)", reading.date),
          avg(reading.humidity)}

    Repo.all(query)
  end

  defp humidity_hour(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('hour', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('hour', ?)", reading.date),
          avg(reading.humidity)}

    Repo.all(query)
  end

  defp humidity_day(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('day', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('day', ?)", reading.date),
          avg(reading.humidity)}

    Repo.all(query)
  end

  # ACCELEROMETER
  def accelerometer_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    with {:ok, hive_id} <- Apiaries.hive_id_filter(params) do
      case group do
        "minute" -> {:ok, accelerometer_minute(date, time_frame, hive_id)}
        "hour" -> {:ok, accelerometer_hour(date, time_frame, hive_id)}
        "day" -> {:ok, accelerometer_day(date, time_frame, hive_id)}
      end
    end
  end

  defp accelerometer_minute(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('minute', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('minute', ?)", reading.date),
          avg(reading.accelerometer)}

    Repo.all(query)
  end

  defp accelerometer_hour(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('hour', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('hour', ?)", reading.date),
          avg(reading.accelerometer)}

    Repo.all(query)
  end

  defp accelerometer_day(min_date, max_date, hive_id) do
    query =
      from reading in Reading,
        group_by: fragment("date_part('day', ?)", reading.date),
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        #order_by: reading.date,
        select:
          {fragment("date_part('day', ?)", reading.date),
          avg(reading.accelerometer)}

    Repo.all(query)
  end
end
