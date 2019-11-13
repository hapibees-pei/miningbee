defmodule Miningbee.SensorFactory do
  defmacro __using__(_opts) do
    quote do
      def sensor_factory do
        %Miningbee.Models.Sensor{
          hive_id: Ecto.UUID.generate(),
          apiary_id: insert(:gateway).apiary_id,
          topic: "topic123"
        }
      end
    end
  end
end
