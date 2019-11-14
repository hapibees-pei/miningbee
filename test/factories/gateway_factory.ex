defmodule Miningbee.GatewayFactory do
  defmacro __using__(_opts) do
    quote do
      def gateway_factory do
        %Miningbee.Apiaries.Gateway{
          apiary_id: Ecto.UUID.generate(),
          topic: "topic123"
        }
      end
    end
  end
end
