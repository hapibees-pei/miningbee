defmodule MiningbeeWeb.GatewayView do
  use MiningbeeWeb, :view
  alias MiningbeeWeb.GatewayView

  def render("index.json", %{gateways: gateways}) do
    %{data: render_many(gateways, GatewayView, "gateway.json")}
  end

  def render("show.json", %{gateway: gateway}) do
    %{data: render_one(gateway, GatewayView, "gateway.json")}
  end

  def render("gateway.json", %{gateway: gateway}) do
    %{
      apiary_id: gateway.apiary_id,
      topic: gateway.topic
    }
  end
end
