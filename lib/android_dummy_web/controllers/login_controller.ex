defmodule AndroidDummyWeb.LoginController do
  use AndroidDummyWeb, :controller
  alias AndroidDummyWeb.Token

  defp admin_hashed do
    :crypto.hash(:sha256, "admin")
    |> Base.encode16
  end

  def login(conn, %{"username" => "admin", "password" => password} = _params) do
    if String.upcase(password) == admin_hashed() do
      {:ok, token, _claims} = Token.generate_and_sign()
      json(conn, %{token: token})
    else
      conn
      |> put_status(400)
      |> json(%{error: "Wrong password"})
    end
  end

  def login(conn, %{"username" => "user1", "password" => _password} = _params) do
    {:ok, token, _claims} = Token.generate_and_sign()
    json(conn, %{token: token})
end

  def login(conn, %{"username" => "user" <> _number, "password" => _password} = _params) do
      {:ok, token, _claims} = Token.generate_and_sign(%{"exp" => Joken.CurrentTime.OS.current_time() + 60})
      json(conn, %{token: token})
  end
end
