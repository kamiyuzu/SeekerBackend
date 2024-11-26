defmodule AndroidDummyWeb.LoginController do
  use AndroidDummyWeb, :controller
  alias AndroidDummyWeb.Token

  defp admin_hashed do
    :crypto.hash(:sha256, "admin")
    |> Base.encode16
  end

  def login(conn, %{"username" => "admin", "password" => password} = params) do
    if String.upcase(password) == admin_hashed() do
      {:ok, token, claims} = Token.generate_and_sign()
      json(conn, %{token: token})
    else
      conn
      |> put_status(400)
      |> json(%{error: "Wrong password"})
    end
  end

  def login(conn, %{"username" => "user" <> _number, "password" => _password} = params) do
      {:ok, token, claims} = Token.generate_and_sign(%{"exp" => 60})
      json(conn, %{token: token})
  end
end
