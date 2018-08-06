defmodule BookselfWeb.GraphQL.Libraries.Mutations.DeleteLibraryTest do
  use BookselfWeb.ConnCase, async: true

  import Bookself.Factory

  setup do
    user = insert(:user)
    library = insert(:library, user_id: user.id)

    token = BookselfWeb.Authentication.sign_user(user)

    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn, library: library}
  end

  @query """
  mutation ($id: ID) {
    deleteLibrary(id: $id)
  }
  """
  test "delete the library", %{conn: conn, library: library} do
    options = %{
      query: @query,
      variables: %{
        id: library.id
      }
    }

    response = post(conn, "/graphql", options)

    assert %{
      "data" => %{
        "deleteLibrary" => "Library was successfully deleted"
      }
    } = json_response(response, 200)
  end
end
