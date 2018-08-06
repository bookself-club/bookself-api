defmodule BookselfWeb.GraphQL.Libraries.Mutations.UpdateLibraryTest do
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
  mutation ($input: LibraryInput, $id: ID) {
    updateLibrary(id: $id, input: $input) {
      errors {
        key
        message
      }
      library {
        name
      }
    }
  }
  """
  test "update a new library", %{conn: conn, library: library} do
    options = %{
      query: @query,
      variables: %{
        id: library.id,
        input: %{
          name: "Updated Library",
        }
      }
    }

    response = post(conn, "/graphql", options)

    assert %{
      "data" => %{
        "updateLibrary" => %{
          "errors" => nil,
          "library" => %{
            "name" => "Updated Library"
          }
        }
      }
    } = json_response(response, 200)
  end

  test "returns errors when input is invalid", %{conn: conn, library: library} do
    options = %{
      query: @query,
      variables: %{
        id: library.id,
        input: %{
          name: ""
        }
      }
    }

    response = post(conn, "/graphql", options)

    assert json_response(response, 200) == %{
      "data" => %{
        "updateLibrary" => %{
          "errors" => [
            %{
              "key" => "name",
              "message" => "can't be blank"
            }
          ],
          "library" => nil
        }
      }
    }
  end
end
