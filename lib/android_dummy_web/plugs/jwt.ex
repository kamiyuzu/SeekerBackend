defmodule AndroidDummyWeb.Plugs.JWT do
    @moduledoc """
    The JWT Plug.
    """

  import Plug.Conn
  use AndroidDummyWeb, :controller
  alias AndroidDummyWeb.Token

  @api_key_header "jwt"
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def call(conn, _opts) do
    token = get_token_from_header(conn)
    case Token.verify_and_validate(token) do
      {:ok, _claims_map} ->
        conn
      {:error, error} when is_list(error) ->
        error_message = Access.fetch!(error, :message)
        send_resp(conn, 403, error_message)
        |> halt()
      {:error, error} when is_atom(error) ->
        send_resp(conn, 403, Atom.to_string(error))
        |> halt()
    end
  end

  defp get_token_from_header(conn) do
    case get_req_header(conn, @api_key_header) do
      [val | _] -> val
      _ -> nil
    end
  end
end
