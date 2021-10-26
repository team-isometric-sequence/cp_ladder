defmodule CpLadder.AuthErrorHandler do
  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{ok: false, data: nil, errors: to_string(type)})
    send_resp(conn, 401, body)
  end

end
