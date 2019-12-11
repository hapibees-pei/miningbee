defmodule Miningbee.Onboarding do
  alias Miningbee.Onboarding.TcpClient

  def create_onboarding(ip, port, uuid) do
    # ip must be inside '' and not "" because of Erlang
    with {:ok, _pid} <-
           TcpClient.start(to_charlist(ip), String.to_integer(port), uuid) do
      {:ok, "onboarding started"}
    end
  end
end
