defmodule MiningbeeWeb.StatisticsView do
  use MiningbeeWeb, :view
  alias MiningbeeWeb.StatisticsView

  def render("show.json", %{statistic: statistic}) do
    %{data: render_many(statistic, StatisticsView, "statistics.json")}
  end

  def render("statistics.json", %{statistic: statistic}) do
    %{
      #timestamp: statistic.timestamp, 
      #reading: statistic.reading
    }
  end
end
