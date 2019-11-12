defmodule MiningbeeWeb.GatewayControllerTest do
  use MiningbeeWeb.ConnCase

  alias Miningbee.Models
  alias Miningbee.Models.Gateway


  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "GET /gateways", %{conn: conn} do

      build(:gateway)
      conn = get(conn, Routes.gateway_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

end
