defmodule MiningbeeWeb.SensorView do
  use MiningbeeWeb, :view
  alias MiningbeeWeb.SensorView

  def render("index.json", %{sensors: sensors}) do
    %{data: render_many(sensors, SensorView, "sensor.json")}
  end

  def render("show.json", %{sensor: sensor}) do
    %{data: render_one(sensor, SensorView, "sensor.json")}
  end

  def render("sensor.json", %{sensor: sensor}) do
    %{
      hive_id: sensor.hive_id,
      topic: sensor.topic,
      apiary_id: sensor.apiary_id
    }
  end
end
