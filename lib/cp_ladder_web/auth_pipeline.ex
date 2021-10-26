defmodule CpLadder.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :cp_ladder,
  module: CpLadder.Guardian,
  error_handler: CpLadder.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
