defmodule Eligit.Repo do
  use Ecto.Repo,
    otp_app: :eligit,
    adapter: Ecto.Adapters.Postgres
end
