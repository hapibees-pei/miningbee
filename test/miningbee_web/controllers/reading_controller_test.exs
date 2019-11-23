defmodule MiningbeeWeb.ReadingControllerTest do
  use MiningbeeWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "Show Light Readings Statistics" do
    test "GET /readings?query=light", %{conn: conn} do
      # insert readings

      conn = get(conn, Routes.reading_path(conn, :show, query: "light"))
      # at least for now
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "Show Pressure Readings Statistics" do
    test "GET /readings?query=pressure", %{conn: conn} do
      # insert readings

      conn = get(conn, Routes.reading_path(conn, :show, query: "pressure"))
      # at least for now
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "Show Sound Readings Statistics" do
    test "GET /readings?query=sound", %{conn: conn} do
      # insert readings

      conn = get(conn, Routes.reading_path(conn, :show, query: "sound"))
      # at least for now
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "Show Temperature Readings Statistics" do
    test "GET /readings?query=temperature", %{conn: conn} do
      # insert readings

      conn =
        get(conn, Routes.reading_path(conn, :show, query: "temperature"))

      # at least for now
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "Show Humidity Readings Statistics" do
    test "GET /readings?query=humidity", %{conn: conn} do
      # insert readings

      conn =
        get(conn, Routes.reading_path(conn, :show, query: "humidity"))

      # at least for now
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "Show Accelerometer Readings Statistics" do
    test "GET /readings?query=accelerometer", %{conn: conn} do
      # insert readings

      conn =
        get(conn, Routes.reading_path(conn, :show, query: "accelerometer"))

      # at least for now
      assert json_response(conn, 200)["data"] == []
    end
  end
end
