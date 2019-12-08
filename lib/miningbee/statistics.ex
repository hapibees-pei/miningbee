defmodule Miningbee.Statistics do
  import Ecto.Query, warn: false
  alias Miningbee.Apiaries
  alias Miningbee.Apiaries.Reading
  alias Miningbee.Repo

  # LIGHT
  def light_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    interval = Apiaries.stats_data_padding(time_frame, date, group)

    with {hive_id, apiary_id} <- Apiaries.params_filter(params) do
      data = light_query(time_frame, date, hive_id, apiary_id)

      Apiaries.merge_empty_data(interval, data, group)
    end
  end

  defp light_query(min_date, max_date, hive_id, apiary_id) do
    query =
      from reading in Reading,
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        where: reading.apiary_id == ^apiary_id,
        select: {reading.date, reading.light}

    Repo.all(query)
  end

  # PRESSURE
  def pressure_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    interval = Apiaries.stats_data_padding(time_frame, date, group)

    with {hive_id, apiary_id} <- Apiaries.params_filter(params) do
      data = pressure_query(time_frame, date, hive_id, apiary_id)

      Apiaries.merge_empty_data(interval, data, group)
    end
  end

  defp pressure_query(min_date, max_date, hive_id, apiary_id) do
    query =
      from reading in Reading,
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        where: reading.apiary_id == ^apiary_id,
        select: {reading.date, reading.pressure}

    Repo.all(query)
  end

  # NOISE
  def noise_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    interval = Apiaries.stats_data_padding(time_frame, date, group)

    with {hive_id, apiary_id} <- Apiaries.params_filter(params) do
      data = noise_query(time_frame, date, hive_id, apiary_id)

      Apiaries.merge_empty_data(interval, data, group)
    end
  end

  defp noise_query(min_date, max_date, hive_id, apiary_id) do
    query =
      from reading in Reading,
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        where: reading.apiary_id == ^apiary_id,
        select: {reading.date, reading.noise}

    Repo.all(query)
  end

  # TEMPERATURE
  def temperature_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    interval = Apiaries.stats_data_padding(time_frame, date, group)

    with {hive_id, apiary_id} <- Apiaries.params_filter(params) do
      data = temperature_query(time_frame, date, hive_id, apiary_id)

      Apiaries.merge_empty_data(interval, data, group)
    end
  end

  defp temperature_query(min_date, max_date, hive_id, apiary_id) do
    query =
      from reading in Reading,
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        where: reading.apiary_id == ^apiary_id,
        select: {reading.date, reading.temperature}

    Repo.all(query)
  end

  # HUMIDITY
  def humidity_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    interval = Apiaries.stats_data_padding(time_frame, date, group)

    with {hive_id, apiary_id} <- Apiaries.params_filter(params) do
      data = humidity_query(time_frame, date, hive_id, apiary_id)

      Apiaries.merge_empty_data(interval, data, group)
    end
  end

  defp humidity_query(min_date, max_date, hive_id, apiary_id) do
    query =
      from reading in Reading,
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        where: reading.apiary_id == ^apiary_id,
        select: {reading.date, reading.humidity}

    Repo.all(query)
  end

  # ACCELEROMETER
  def accelerometer_stat(params) do
    date = Apiaries.stats_date_filter(params)
    group = Apiaries.stats_group_filter(params)
    time_frame = Apiaries.stats_time_frame(date, group)

    interval = Apiaries.stats_data_padding(time_frame, date, group)

    with {hive_id, apiary_id} <- Apiaries.params_filter(params) do
      data = accelerometer_query(time_frame, date, hive_id, apiary_id)

      Apiaries.merge_empty_data(interval, data, group)
    end
  end

  defp accelerometer_query(min_date, max_date, hive_id, apiary_id) do
    query =
      from reading in Reading,
        where: reading.date >= ^min_date,
        where: reading.date <= ^max_date,
        where: reading.hive_id == ^hive_id,
        where: reading.apiary_id == ^apiary_id,
        select: {reading.date, reading.accelerometer}

    Repo.all(query)
  end
end
