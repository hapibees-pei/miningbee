ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Miningbee.Repo, :manual)
{:ok, _} = Miningbee.ensure_all_started(:ex_machina)
