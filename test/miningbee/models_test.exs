defmodule Miningbee.ModelsTest do
  use Miningbee.DataCase

  alias Miningbee.Models

  describe "gateways" do
    alias Miningbee.Models.Gateway

    @valid_attrs %{topic: "some topic"}
    @update_attrs %{topic: "some updated topic"}
    @invalid_attrs %{topic: nil}

    test "list_gateways/0 returns all gateways" do
      gateway = insert(:gateway)
      assert Models.list_gateways() == [gateway]
    end

    test "get_gateway!/1 returns the gateway with given id" do
      gateway = insert(:gateway)
      assert Models.get_gateway!(gateway.apiary_id) == gateway
    end

    test "create_gateway/1 with valid data creates a gateway" do
      assert {:ok, %Gateway{} = gateway} = Models.create_gateway(@valid_attrs)
      assert gateway.topic == "some topic"
    end

    test "create_gateway/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Models.create_gateway(@invalid_attrs)
    end

    test "update_gateway/2 with valid data updates the gateway" do
      gateway = insert(:gateway)
      assert {:ok, %Gateway{} = gateway} = Models.update_gateway(gateway, @update_attrs)
      assert gateway.topic == "some updated topic"
    end

    test "update_gateway/2 with invalid data returns error changeset" do
      gateway = insert(:gateway)
      assert {:error, %Ecto.Changeset{}} = Models.update_gateway(gateway, @invalid_attrs)
      assert gateway == Models.get_gateway!(gateway.apiary_id)
    end

    test "delete_gateway/1 deletes the gateway" do
      gateway = insert(:gateway)
      assert {:ok, %Gateway{}} = Models.delete_gateway(gateway)
      assert_raise Ecto.NoResultsError, fn -> Models.get_gateway!(gateway.apiary_id) end
    end

  end

  describe "sensors" do
    alias Miningbee.Models.Sensor

    @update_attrs %{topic: "some updated topic"}
    @invalid_attrs %{topic: nil}

    test "list_sensors/0 returns all sensors" do
      sensor = insert(:sensor)
      assert Models.list_sensors() == [sensor]
    end

    test "get_sensor!/1 returns the sensor with given id" do
      sensor = insert(:sensor)
      assert Models.get_sensor!(sensor.hive_id) == sensor
    end

    test "create_sensor/1 with valid data creates a sensor" do
      gateway = insert(:gateway)
      struct = %{apiary_id: gateway.apiary_id, topic: "some topic"}

      assert {:ok, %Sensor{} = sensor} = Models.create_sensor(struct)
      assert sensor.apiary_id == gateway.apiary_id
      assert sensor.topic == "some topic"
    end

    test "create_sensor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Models.create_sensor(@invalid_attrs)
    end

    test "update_sensor/2 with valid data updates the sensor" do
      sensor = insert(:sensor)
      assert {:ok, %Sensor{} = sensor} = Models.update_sensor(sensor, @update_attrs)
      assert sensor.topic == "some updated topic"
    end

    test "update_sensor/2 with invalid data returns error changeset" do
      sensor = insert(:sensor)
      assert {:error, %Ecto.Changeset{}} = Models.update_sensor(sensor, @invalid_attrs)
      assert sensor == Models.get_sensor!(sensor.hive_id)
    end

    test "delete_sensor/1 deletes the sensor" do
      sensor = insert(:sensor)
      assert {:ok, %Sensor{}} = Models.delete_sensor(sensor)
      assert_raise Ecto.NoResultsError, fn -> Models.get_sensor!(sensor.hive_id) end
    end

  end
end
