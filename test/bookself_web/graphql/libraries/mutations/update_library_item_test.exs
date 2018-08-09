defmodule BookselfWeb.GraphQL.Libraries.Mutations.UpdateLibraryItemTest do
  use BookselfWeb.ConnCase, async: true

  import Bookself.Factory

  setup do
    user    = insert(:user)
    library = insert(:library, user: user)
    book    = insert(:book)
    item    = insert(:library_item, library: library, book: book)

    token = BookselfWeb.Authentication.sign_user(user)

    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn, item: item}
  end

  @query """
  mutation ($id: ID, $input: UpdateLibraryItemInput) {
    updateLibraryItem(id: $id, input: $input) {
      errors {
        key
        message
      }
      libraryItem {
        status
        rating
      }
    }
  }
  """
  test "update the library item", %{conn: conn, item: item} do
    options = %{
      query: @query,
      variables: %{
        id: item.id,
        input: %{
          status: "HAVE",
          rating: 5,
        }
      }
    }

    response = post(conn, "/graphql", options)

    assert %{
      "data" => %{
        "updateLibraryItem" => %{
          "errors" => nil,
          "libraryItem" => %{
            "status" => "have",
            "rating" => 5
          }
        }
      }
    } = json_response(response, 200)
  end
end
