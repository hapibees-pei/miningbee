defmodule Miningbee.Redis.Pool do
  require Logger

  def child_spec(_args) do
    Logger.info("#{host()} #{port()} #{pool_size()}")

    children =
      for i <- 0..(pool_size - 1) do
        Supervisor.child_spec(
          {Redix, host: host(), port: port(), name: :"redix_#{i}"},
          id: {Redix, i}
        )
      end

    Logger.info("Starting Redis Supervisor")

    %{
      id: RedixSupervisor,
      type: :supervisor,
      start: {Supervisor, :start_link, [children, [strategy: :one_for_one]]}
    }
  end

  def command(command) do
    Logger.info("Command <#{command}> to redix_#{random_index()}")
    Redix.command(:"redix_#{random_index()}", command)
  end

  defp random_index() do
    rem(System.unique_integer([:positive]), pool_size())
  end

  defp host do
    Application.get_env(:miningbee, __MODULE__)[:host]
  end

  defp port do
    Application.get_env(:miningbee, __MODULE__)[:port]
  end

  defp pool_size do
    Application.get_env(:miningbee, __MODULE__)[:pool_size]
  end
end
