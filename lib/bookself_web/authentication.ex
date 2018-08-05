defmodule BookselfWeb.Authentication do
  @moduledoc false
  import Joken

  @secret System.get_env("JWT_SECRET") || "default salt"

  def sign_user(user) do
    %{email: user.email , name: user.name}
    |> token
    |> with_signer(hs256(@secret))
    |> sign
    |> get_compact
  end

  def verify_token(token) do
    token
    |> decode_token
    |> handle_verify_response
  end

  defp decode_token(token) do
    token
    |> token
    |> with_signer(hs256(@secret))
    |> verify
  end

  defp handle_verify_response(response) do
    case response do
      %Joken.Token{claims: %{"email" => email, "name" => name}} ->
        {:ok, %{email: email, name: name}}
      _ ->
        {:error, "invalid token" }
    end
  end
end
