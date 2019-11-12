defmodule Miningbee.Models do

  import Ecto.Query, warn: false
  alias Miningbee.Repo

  alias Miningbee.Models.Gateway

  ## GATEWAYS
  def list_gateways do
    Repo.all(Gateway)
  end
  
  def get_gateway!(id), do: Repo.get!(Gateway, id)

  def create_gateway(attrs \\ %{}) do
    %Gateway{}
    |> Gateway.changeset(attrs)
    |> Repo.insert()
  end

  def update_gateway(%Gateway{} = gateway, attrs) do
    gateway
    |> Gateway.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_gateway(%Gateway{} = gateway) do
    Repo.delete(gateway)
  end

  ## SENSORS

end
