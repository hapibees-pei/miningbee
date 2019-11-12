defmodule Miningbee.Factory do
  use ExMachina.Ecto, repo: Miningbee.Repo
  use Miningbee.GatewayFactory
end
