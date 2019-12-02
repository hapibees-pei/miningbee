defmodule MiningbeeWeb.ReadingView do
  use MiningbeeWeb, :view
  alias MiningbeeWeb.ReadingView

  def render("show.json", %{reading: reading}) do
    %{data: render_many(reading, ReadingView, "reading.json")}
  end

  # Later substitute by indivual reading Type View
  def render("reading.json", %{reading: reading}) do
    %{
      date: elem(reading, 0),
      value: elem(reading, 1),
    }
  end
end
