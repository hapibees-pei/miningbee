defmodule MiningbeeWeb.GatewayControllerTest do
  use MiningbeeWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "Index Gateways" do
    test "GET /gateways", %{conn: conn} do
      insert(:gateway)
      conn = get(conn, Routes.gateway_path(conn, :index))
      assert json_response(conn, 200)["data"] != []
    end
  end

  describe "Show Gateway" do
    test "GET /gateways/:id", %{conn: conn} do
      gateway = insert(:gateway)

      conn = get(conn, Routes.gateway_path(conn, :show, gateway.apiary_id))
      assert json_response(conn, 200)["data"] != []
    end
  end

  describe "Create Gateway" do
    test "POST /gateways", %{conn: conn} do
      struct = %{"gateway" => %{"topic" => "topic123"}}

      conn =
        conn
        |> post(Routes.gateway_path(conn, :create), struct)

      assert json_response(conn, 201)["data"] != []
    end
  end

  describe "Update Gateway" do
    test "PATCH /gateways/:id", %{conn: conn} do
      gateway = insert(:gateway)
      struct = %{"gateway" => %{"topic" => "new topic123"}}

      conn =
        conn
        |> patch(Routes.gateway_path(conn, :update, gateway.apiary_id), struct)

      assert json_response(conn, 200)["data"] != []
    end
  end

  describe "Delete Gateway" do
    test "DELETE /gateways/:id", %{conn: conn} do
      gateway = insert(:gateway)

      conn =
        conn
        |> delete(Routes.gateway_path(conn, :delete, gateway.apiary_id))

      assert conn.status == 204
    end
  end
end
