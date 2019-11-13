defmodule Miningbee.Factory do
  use ExMachina.Ecto, repo: Miningbee.Repo
  use Miningbee.GatewayFactory
  use Miningbee.SensorFactory
end
