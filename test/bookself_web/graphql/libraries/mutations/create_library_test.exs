defmodule BookselfWeb.GraphQL.Libraries.Mutations.CreateLibraryTest do
  use BookselfWeb.ConnCase, async: true

  import Bookself.Factory

  setup do
    user = insert(:user)

    token = BookselfWeb.Authentication.sign_user(user)

    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn}
  end

  @query """
  mutation ($input: LibraryInput) {
    createLibrary(input: $input) {
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
  test "create a new library", %{conn: conn} do
    options = %{
      query: @query,
      variables: %{
        input: %{
          name: "New Library",
        }
      }
    }

    response = post(conn, "/graphql", options)

    assert %{
      "data" => %{
        "createLibrary" => %{
          "errors" => nil,
          "library" => %{
            "name" => "New Library"
          }
        }
      }
    } = json_response(response, 200)
  end

  test "returns errors when input is invalid", %{conn: conn} do
    options = %{
      query: @query,
      variables: %{
        input: %{
          name: ""
        }
      }
    }

    response = post(conn, "/graphql", options)

    assert json_response(response, 200) == %{
      "data" => %{
        "createLibrary" => %{
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
