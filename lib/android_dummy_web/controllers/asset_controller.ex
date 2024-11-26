defmodule AndroidDummyWeb.AsserController do
  use AndroidDummyWeb, :controller

  def login(conn, %{"latitude" => latitude, "longitude" => longitude, "set" => set_number} = params) do

    conn
    |> resp(200, "OK")
    |> send_resp()
  end
end
