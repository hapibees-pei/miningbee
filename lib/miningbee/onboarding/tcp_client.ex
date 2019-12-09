defmodule Miningbee.Onboarding.TcpClient do
  use GenServer
  require Logger
  alias Miningbee.Mqtt.Connection

  def start(ip, port, uuid) do
    GenServer.start_link(__MODULE__, %{
      ip: ip,
      port: port,
      uuid: uuid,
      socket: nil
    })
  end

  def init(state) do
    send(self(), :connect)
    {:ok, state}
  end

  def handle_info(
        :connect,
        %{ip: ip, port: port, uuid: uuid} = state
      ) do
    Logger.info("Connecting via #{ip}:#{port} to #{uuid}")

    case :gen_tcp.connect(ip, port, [:binary, {:packet, 0}]) do
      {:ok, socket} ->
        Process.send_after(self(), :work, 0)
        {:noreply, %{uuid: uuid, socket: socket}}

      {:error, _reason} ->
        {:stop, :normal, state}
    end
  end

  def handle_info(:work, %{socket: sock, uuid: uuid} = state) do
    announce_gateway(sock, uuid)
    schedule_work(60_000)
    {:noreply, state}
  end

  def handle_info({:tcp, _socket, "success"}, state) do
    Logger.info("Terminated")
    {:stop, :normal, state}
  end

  def handle_info({:tcp, _socket, packet}, state) do
    Logger.info(packet)
    {:noreply, state}
  end

  def handle_info({:tcp_closed, _socket}, state) do
    Logger.info("socket has been closed")
    {:noreply, state}
  end

  def handle_info({:tcp_error, _socket, reason}, state) do
    Logger.info("connection closed due to #{reason}")
    {:noreply, state}
  end

  defp announce_gateway(sock, uuid) do
    broker_ip = Connection.host()
    broker_port = Connection.port()

    :gen_tcp.send(
      sock,
      "{\"ip\": \"#{broker_ip}\", \"port\": #{broker_port}, \"uuid\": \"#{uuid}\"}"
    )
  end

  defp schedule_work(period) do
    Process.send_after(self(), :work, period)
  end
end
