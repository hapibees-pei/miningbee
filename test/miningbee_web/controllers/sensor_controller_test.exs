defmodule MiningbeeWeb.SensorControllerTest do
  use MiningbeeWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "Index Sensors" do
    test "GET /sensors", %{conn: conn} do

      insert(:sensor)
      conn = get(conn, Routes.sensor_path(conn, :index))
      assert json_response(conn, 200)["data"] != []
    end
  end

  describe "Show Sensor" do
    test "GET /sensors/:id", %{conn: conn} do

      sensor = insert(:sensor)

      conn = get(conn, Routes.sensor_path(conn, :show, sensor.hive_id))
      assert json_response(conn, 200)["data"] != []
    end
  end

  describe "Create Sensor" do
    test "POST /sensors", %{conn: conn} do

      gateway = insert(:gateway)
      struct = %{"sensor" => %{"topic" => "topic123", "apiary_id" => gateway.apiary_id}}
      conn = conn
        |> post(Routes.sensor_path(conn, :create), struct)
      assert json_response(conn, 201)["data"] != []
    end
  end

  describe "Update Sensor" do
    test "PATCH /sensors/:id", %{conn: conn} do

      sensor = insert(:sensor)
      struct = %{"sensor" => %{"topic" => "new topic123"}}
      conn = conn
        |> patch(Routes.sensor_path(conn, :update, sensor.hive_id), struct)
      assert json_response(conn, 200)["data"] != []
    end
  end

  describe "Delete Sensor" do
    test "DELETE /sensors/:id", %{conn: conn} do

      sensor = insert(:sensor)
      conn = conn
        |> delete(Routes.sensor_path(conn, :delete, sensor.hive_id))
      assert conn.status == 204
    end
  end

end
