defmodule Oxebanking.Repo do
  use Ecto.Repo,
    otp_app: :oxebanking,
    adapter: Ecto.Adapters.Postgres
end
