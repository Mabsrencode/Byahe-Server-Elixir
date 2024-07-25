defmodule DriverUserCoordinates.Repo do
  use Ecto.Repo,
    otp_app: :driver_user_coordinates,
    adapter: Ecto.Adapters.Postgres
end
