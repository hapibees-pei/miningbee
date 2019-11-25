defmodule Miningbee.Mqtt.Handler do
  require Logger
  require Jason

  use Tortoise.Handler

  @impl true
  def init(_opts) do
    {:ok, []}
  end

  @impl true
  def connection(:up, state) do
    Logger.info("Connection has been established")
    {:ok, state}
  end

  def connection(:down, state) do
    Logger.warn("Connection has been dropped")
    {:ok, state}
  end

  @impl true
  def subscription(:up, topic, state) do
    Logger.info("Subscribed to #{topic}")
    {:ok, state}
  end

  def subscription({:warn, [requested: req, accepted: qos]}, topic, state) do
    Logger.warn(
      "Subscribed to #{topic}; requested #{req} but got accepted with QoS #{qos}"
    )

    {:ok, state}
  end

  def subscription({:error, reason}, topic, state) do
    Logger.error("Error subscribing to #{topic}; #{inspect(reason)}")
    {:ok, state}
  end

  def subscription(:down, topic, state) do
    Logger.info("Unsubscribed from #{topic}")
    {:ok, state}
  end

  @impl true
  def handle_message(_topic, publish, state) do
    Logger.info("Unsubscribed from #{publish}")
    {:ok, state}
  end

  @impl true
  def terminate(reason, _state) do
    Logger.warn("Client has been terminated with reason: #{inspect(reason)}")
    :ok
  end
end