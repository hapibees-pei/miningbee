defmodule Miningbee.GatewayFactory do
  defmacro __using__(_opts) do
    quote do
      def gateway_factory do
        %Miningbee.Models.Gateway{
          topic: "topic123"
        }
      end
    end
  end
end
