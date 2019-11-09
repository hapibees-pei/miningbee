defmodule MiningbeeWeb.Router do
  use MiningbeeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MiningbeeWeb do
    pipe_through :api
  end
end
