defmodule MiningbeeWeb.OnboardingController do
  use MiningbeeWeb, :controller

  alias Miningbee.Onboarding

  action_fallback MiningbeeWeb.FallbackController

  def create(conn, %{
        "onboarding" => %{"ip" => ip, "port" => port, "uuid" => uuid}
      }) do
    with {:ok, onboarding} <- Onboarding.create_onboarding(ip, port, uuid) do
      conn
      |> put_status(:created)
      |> render("show.json", onboarding: onboarding)
    end
  end
end
