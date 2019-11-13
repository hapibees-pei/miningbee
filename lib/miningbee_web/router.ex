defmodule MiningbeeWeb.Router do
  use MiningbeeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MiningbeeWeb do
    pipe_through :api

    scope "/v1" do
      #Gateways
      resources "/gateways", GatewayController, only: [:show, :index, :create, :update, :delete]
      #Sensors
      resources "/sensors", SensorController, only: [:show, :index, :create, :update, :delete]
    end
  end
end
