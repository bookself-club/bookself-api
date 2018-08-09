defmodule BookselfWeb.GraphQL.Libraries.Mutations.CreateLibraryItemTest do
  use BookselfWeb.ConnCase, async: true

  import Bookself.Factory

  setup do
    user    = insert(:user)
    library = insert(:library, user: user)
    book    = insert(:book)

    token = BookselfWeb.Authentication.sign_user(user)

    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn, library: library, book: book}
  end

  @query """
  mutation ($input: CreateLibraryItemInput) {
    addLibraryItem(input: $input) {
      errors {
        key
        message
      }
      libraryItem {
        book {
          title
        }
      }
    }
  }
  """
  test "create a new library item", %{conn: conn, library: library, book: book} do
    options = %{
      query: @query,
      variables: %{
        input: %{
          library_id: library.id,
          book_id: book.id,
        }
      }
    }

    response = post(conn, "/graphql", options)

    assert %{
      "data" => %{
        "addLibraryItem" => %{
          "errors" => nil,
          "libraryItem" => %{
            "book" => %{
              "title" => "Title"
            }
          }
        }
      }
    } = json_response(response, 200)
  end

  test "returns errors the book already in library", %{conn: conn, library: library, book: book} do
    options = %{
      query: @query,
      variables: %{
        input: %{
          library_id: library.id,
          book_id: book.id,
        }
      }
    }

    insert(:library_item, library: library, book: book)

    response = post(conn, "/graphql", options)

    assert %{
      "data" => %{
        "addLibraryItem" => nil
      },
      "errors" => [%{
        "locations" => _,
        "message" => "Book already in library",
        "path" => _
      }]
    } = json_response(response, 200)
  end
end
