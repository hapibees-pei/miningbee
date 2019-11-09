defmodule Miningbee.Repo do
  use Ecto.Repo,
    otp_app: :miningbee,
    adapter: Ecto.Adapters.Postgres
end
