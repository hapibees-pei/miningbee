defmodule Miningbee.Mqtt.Connection do
  use Supervisor
  alias Miningbee.Mqtt.Handler

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    children = [
      {Tortoise.Connection,
       [
         client_id: client_id(),
         server: {Tortoise.Transport.Tcp, host: host(), port: port()},
         user_name: user_name(),
         password: password(),
         handler: {Handler, []},
         keep_alive: keep_alive(),
         subscriptions: [{subscriptions(), 0}]
       ]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp client_id do
    Application.get_env(:miningbee, __MODULE__)[:client_id]
  end

  def host do
    Application.get_env(:miningbee, __MODULE__)[:host]
  end

  def port do
    Application.get_env(:miningbee, __MODULE__)[:port]
  end

  defp user_name do
    Application.get_env(:miningbee, __MODULE__)[:user_name]
  end

  defp password do
    Application.get_env(:miningbee, __MODULE__)[:password]
  end

  defp keep_alive do
    Application.get_env(:miningbee, __MODULE__)[:keep_alive]
  end

  defp subscriptions do
    Application.get_env(:miningbee, __MODULE__)[:subscriptions]
  end
end
