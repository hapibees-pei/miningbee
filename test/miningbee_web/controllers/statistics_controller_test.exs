defmodule MiningbeeWeb.StatisticsControllerTest do
  use MiningbeeWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "Show Light Statistics" do
    test "GET /statistics?query=light", %{conn: conn} do

      #insert readings

      conn = get(conn, Routes.statistics_path(conn, :show, query: "light"))
      assert json_response(conn, 200)["data"] == [] #at least for now
    end
  end

  describe "Show Pressure Statistics" do
    test "GET /statistics?query=pressure", %{conn: conn} do

      #insert readings

      conn = get(conn, Routes.statistics_path(conn, :show, query: "pressure"))
      assert json_response(conn, 200)["data"] == [] #at least for now
    end
  end

  describe "Show Sound Statistics" do
    test "GET /statistics?query=sound", %{conn: conn} do

      #insert readings

      conn = get(conn, Routes.statistics_path(conn, :show, query: "sound"))
      assert json_response(conn, 200)["data"] == [] #at least for now
    end
  end

  describe "Show Temperature Statistics" do
    test "GET /statistics?query=temperature", %{conn: conn} do

      #insert readings

      conn = get(conn, Routes.statistics_path(conn, :show, query: "temperature"))
      assert json_response(conn, 200)["data"] == [] #at least for now
    end
  end

end
