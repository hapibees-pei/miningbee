defmodule Miningbee.Onboarding do

  alias Miningbee.Onboarding.TcpClient

  def create_onboarding(ip, port, uuid) do
    # ip must be inside '' and not "" because of Erlang
    with {:ok, sock} = TcpClient.start_link(ip, port) do 
      IO.inspect TcpClient.schedule_work(0, sock, uuid)
      {:ok, "onboarding started"}
    end
  end
end
