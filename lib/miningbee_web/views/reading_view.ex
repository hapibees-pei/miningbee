defmodule MiningbeeWeb.ReadingView do
  use MiningbeeWeb, :view
  alias MiningbeeWeb.ReadingView

  def render("index.json", %{readings: readings}) do
    %{data: render_many(readings, ReadingView, "reading.json")}
  end

  def render("show.json", %{reading: reading}) do
    %{data: render_one(reading, ReadingView, "reading.json")}
  end

  def render("reading.json", %{reading: reading}) do
    %{
      id: reading.id,
      temperature: reading.temperature,
      pressure: reading.pressure,
      light: reading.light,
      noise: reading.noise,
      humidity: reading.humidity,
      accelerometer: reading.accelerometer
    }
  end
end