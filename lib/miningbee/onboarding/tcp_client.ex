defmodule Miningbee.Onboarding.TcpClient do
  use GenServer
  alias Miningbee.Mqtt.Connection

  def start_link(ip, port) do
    GenServer.start_link(__MODULE__, [ip, port], [])
  end

  def init([ip, port]) do
    :gen_tcp.connect(ip, port, [:binary, {:packet, 0}])
  end

  def announce_gateway(sock, uuid) do
    broker_ip = Connection.host()
    broker_port = Connection.port()
    :gen_tcp.send(sock, "{\"ip\": #{broker_ip}, \"port\": #{broker_port}, \"uuid\": #{uuid}}")
  end

  def schedule_work(period, sock, uuid) do
    Process.send_after(self(), {:work, sock, uuid}, period)
  end

  def handle_info({:work, sock, uuid}, state) do
    announce_gateway(sock, uuid)
    schedule_work(60000, sock, uuid)
    {:noreply, state}
  end

  def handle_info({:tcp, _socket, "success"}, _state) do
    GenServer.stop(__MODULE__)
  end

  def handle_info({:tcp, socket, packet}, state) do
    IO.inspect(packet, label: "incoming packet")
    :gen_tcp.send(socket, "Hi Blackode \n")
    {:noreply, state}
  end

  def handle_info({:tcp_closed, _socket}, state) do
    IO.inspect("Socket has been closed")
    {:noreply, state}
  end

  def handle_info({:tcp_error, socket, reason}, state) do
    IO.inspect(socket, label: "connection closed dut to #{reason}")
    {:noreply, state}
  end
end
