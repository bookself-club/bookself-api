defmodule BookselfWeb.GraphQL.Middlewares.Authorize do
  @moduledoc false
  @behaviour Absinthe.Middleware

  @doc """
  Verify if the current user is available in the context, if not, add an error
  to `Absinthe.Resolution`
  """
  def call(resolution, _role) do
    with %{current_user: _current_user} <- resolution.context do
      resolution
    else
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unauthorized"})
    end
  end
end
