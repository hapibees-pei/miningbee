defmodule MiningbeeWeb.ReadingView do
  use MiningbeeWeb, :view
  alias MiningbeeWeb.ReadingView

  def render("show.json", %{reading: reading}) do
    %{data: render_many(reading, ReadingView, "reading.json")}
  end

  # Later substitute by indivual reading Type View
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
