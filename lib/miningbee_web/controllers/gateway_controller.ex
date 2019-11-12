defmodule MiningbeeWeb.GatewayController do
  use MiningbeeWeb, :controller

  alias Miningbee.Models
  alias Miningbee.Models.Gateway

  action_fallback MiningbeeWeb.FallbackController

  def index(conn, _params) do
    gateways = Models.list_gateways()
    render(conn, "index.json", gateways: gateways)
  end

  def create(conn, %{"gateway" => gateway_params}) do
    with {:ok, %Gateway{} = gateway} <- Models.create_gateway(gateway_params) do
      conn
      |> put_status(:created)
      |> render("show.json", gateway: gateway)
    end
  end

  def show(conn, %{"id" => id}) do
    gateway = Models.get_gateway!(id)
    render(conn, "show.json", gateway: gateway)
  end

  def update(conn, %{"id" => id, "gateway" => gateway_params}) do
    gateway = Models.get_gateway!(id)

    with {:ok, %Gateway{} = gateway} <- Models.update_gateway(gateway, gateway_params) do
      render(conn, "show.json", gateway: gateway)
    end
  end

  def delete(conn, %{"id" => id}) do
    gateway = Models.get_gateway!(id)

    with {:ok, %Gateway{}} <- Models.delete_gateway(gateway) do
      send_resp(conn, :no_content, "")
    end
  end
end
