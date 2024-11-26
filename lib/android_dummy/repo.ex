defmodule AndroidDummy.Repo do
  use Ecto.Repo,
    otp_app: :android_dummy,
    adapter: Ecto.Adapters.Postgres
end
