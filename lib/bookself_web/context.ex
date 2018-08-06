defmodule BookselfWeb.Context do
  @moduledoc """
  An Plug component to add current user from bearer token to current application
  context.
  """

  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  @doc """
  The `call` method used by Plug, this add the user to Absinthe context
  """
  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
      {:ok, data} <- BookselfWeb.Authentication.verify_token(token),
      %{} = user <- get_user(data) do
        %{current_user: user}
    else
      _ -> %{}
    end
  end

  defp get_user(%{email: email}) do
    Bookself.Accounts.lookup(email)
  end
end
