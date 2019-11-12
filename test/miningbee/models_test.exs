#defmodule Miningbee.ModelsTest do
#  use Miningbee.DataCase
#
#  alias Miningbee.Models
#
#  describe "gateways" do
#    alias Miningbee.Models.Gateway
#
#    @valid_attrs %{topic: "some topic"}
#    @update_attrs %{topic: "some updated topic"}
#    @invalid_attrs %{topic: nil}
#
#    def gateway_fixture(attrs \\ %{}) do
#      {:ok, gateway} =
#        attrs
#        |> Enum.into(@valid_attrs)
#        |> Models.create_gateway()
#
#      gateway
#    end
#
#    test "list_gateways/0 returns all gateways" do
#      gateway = gateway_fixture()
#      assert Models.list_gateways() == [gateway]
#    end
#
#    test "get_gateway!/1 returns the gateway with given id" do
#      gateway = gateway_fixture()
#      assert Models.get_gateway!(gateway.id) == gateway
#    end
#
#    test "create_gateway/1 with valid data creates a gateway" do
#      assert {:ok, %Gateway{} = gateway} = Models.create_gateway(@valid_attrs)
#      assert gateway.topic == "some topic"
#    end
#
#    test "create_gateway/1 with invalid data returns error changeset" do
#      assert {:error, %Ecto.Changeset{}} = Models.create_gateway(@invalid_attrs)
#    end
#
#    test "update_gateway/2 with valid data updates the gateway" do
#      gateway = gateway_fixture()
#      assert {:ok, %Gateway{} = gateway} = Models.update_gateway(gateway, @update_attrs)
#      assert gateway.topic == "some updated topic"
#    end
#
#    test "update_gateway/2 with invalid data returns error changeset" do
#      gateway = gateway_fixture()
#      assert {:error, %Ecto.Changeset{}} = Models.update_gateway(gateway, @invalid_attrs)
#      assert gateway == Models.get_gateway!(gateway.id)
#    end
#
#    test "delete_gateway/1 deletes the gateway" do
#      gateway = gateway_fixture()
#      assert {:ok, %Gateway{}} = Models.delete_gateway(gateway)
#      assert_raise Ecto.NoResultsError, fn -> Models.get_gateway!(gateway.id) end
#    end
#
#    test "change_gateway/1 returns a gateway changeset" do
#      gateway = gateway_fixture()
#      assert %Ecto.Changeset{} = Models.change_gateway(gateway)
#    end
#  end
#end
