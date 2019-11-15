defmodule Miningbee.ApiariesTest do
  use Miningbee.DataCase

  alias Miningbee.Apiaries

  describe "gateways" do
    alias Miningbee.Apiaries.Gateway

    @valid_attrs %{topic: "some topic"}
    @update_attrs %{topic: "some updated topic"}
    @invalid_attrs %{topic: nil}

    test "list_gateways/0 returns all gateways" do
      gateway = insert(:gateway)
      assert Apiaries.list_gateways() == [gateway]
    end

    test "get_gateway!/1 returns the gateway with given id" do
      gateway = insert(:gateway)
      assert Apiaries.get_gateway!(gateway.apiary_id) == gateway
    end

    test "create_gateway/1 with valid data creates a gateway" do
      assert {:ok, %Gateway{} = gateway} = Apiaries.create_gateway(@valid_attrs)
      assert gateway.topic == "some topic"
    end

    test "create_gateway/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apiaries.create_gateway(@invalid_attrs)
    end

    test "update_gateway/2 with valid data updates the gateway" do
      gateway = insert(:gateway)
      assert {:ok, %Gateway{} = gateway} = Apiaries.update_gateway(gateway, @update_attrs)
      assert gateway.topic == "some updated topic"
    end

    test "update_gateway/2 with invalid data returns error changeset" do
      gateway = insert(:gateway)
      assert {:error, %Ecto.Changeset{}} = Apiaries.update_gateway(gateway, @invalid_attrs)
      assert gateway == Apiaries.get_gateway!(gateway.apiary_id)
    end

    test "delete_gateway/1 deletes the gateway" do
      gateway = insert(:gateway)
      assert {:ok, %Gateway{}} = Apiaries.delete_gateway(gateway)
      assert_raise Ecto.NoResultsError, fn -> Apiaries.get_gateway!(gateway.apiary_id) end
    end

  end

  describe "sensors" do
    alias Miningbee.Apiaries.Sensor

    @update_attrs %{topic: "some updated topic"}
    @invalid_attrs %{topic: nil}

    test "list_sensors/0 returns all sensors" do
      sensor = insert(:sensor)
      assert Apiaries.list_sensors() == [sensor]
    end

    test "get_sensor!/1 returns the sensor with given id" do
      sensor = insert(:sensor)
      assert Apiaries.get_sensor!(sensor.hive_id) == sensor
    end

    test "create_sensor/1 with valid data creates a sensor" do
      gateway = insert(:gateway)
      struct = %{apiary_id: gateway.apiary_id, topic: "some topic"}

      assert {:ok, %Sensor{} = sensor} = Apiaries.create_sensor(struct)
      assert sensor.apiary_id == gateway.apiary_id
      assert sensor.topic == "some topic"
    end

    test "create_sensor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apiaries.create_sensor(@invalid_attrs)
    end

    test "update_sensor/2 with valid data updates the sensor" do
      sensor = insert(:sensor)
      assert {:ok, %Sensor{} = sensor} = Apiaries.update_sensor(sensor, @update_attrs)
      assert sensor.topic == "some updated topic"
    end

    test "update_sensor/2 with invalid data returns error changeset" do
      sensor = insert(:sensor)
      assert {:error, %Ecto.Changeset{}} = Apiaries.update_sensor(sensor, @invalid_attrs)
      assert sensor == Apiaries.get_sensor!(sensor.hive_id)
    end

    test "delete_sensor/1 deletes the sensor" do
      sensor = insert(:sensor)
      assert {:ok, %Sensor{}} = Apiaries.delete_sensor(sensor)
      assert_raise Ecto.NoResultsError, fn -> Apiaries.get_sensor!(sensor.hive_id) end
    end

  end
end
