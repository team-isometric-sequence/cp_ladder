defmodule CpLadder.AuthErrorHandler do
  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{ok: false, data: nil, errors: to_string(type)})
    conn
    |> put_resp_header("Content-Type", "application/json")
    |> send_resp(401, body)
  end

end
