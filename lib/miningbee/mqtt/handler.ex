defmodule Miningbee.Mqtt.Handler do
  require Logger
  require Jason

  use Tortoise.Handler

  alias Miningbee.Apiaries
  alias Miningbee.Redis.Pool

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
  def handle_message(["gateway", gateway_id, "status"], publish, state) do
    Logger.info("from #{tail}: #{publish}")

    add_gateway(gateway_id)
    {:ok, state}
  end

  def handle_message(
        ["gateway", gateway_id, "sensors", sensor_id, "status"],
        publish,
        state
      ) do
    Logger.info("from #{tail}: #{publish}")

    add_sensor(gateway_id, sensor_id)
    {:ok, state}
  end

  def handle_message(topic, publish, state) do
    Logger.info("from #{topic}: #{publish}")

    add_reading(topic, publish)
    {:ok, state}
  end

  @impl true
  def terminate(reason, _state) do
    Logger.warn("Client has been terminated with reason: #{inspect(reason)}")
    :ok
  end

  defp device_id(topic), do: topic |> List.last()

  defp hive_id(topic), do: topic |> List.last()

  defp add_reading(topic, publish) do
    hive_id = device_id(topic)

    Pool.command(["SET", hive_id, publish])

    publish
    |> Jason.decode!()
    |> Map.put(:hive_id, hive_id)
    |> Apiaries.create_readings()
  end

  defp add_gateway(gateway_id) do
    # TODO
    # This actually needsd to be an update. The gateway needs to be confirmed because the primary key is the supposely "gateway_id"
    # To solve this circular depency we need to create the gateway and send the primary key alongside the broker information
    # When the gateway connects we need to confirme that its connected
    %{topic: "gateway/#{gateway_id}"}
    |> Apiaries.create_gateway()
  end

  defp add_sensor(gateway_id, sensor_id) do
    # TODO
    # Same as gateway, this should be an update
    %{apiari_id: gateway_id, topic: "gateway/#{gateway_id}/sensor/#{sensor_id}"}
    |> Apiaries.create_sensor()
  end
end
