defmodule BookselfWeb.GraphQL.Accounts.Mutation.UpdateProfileTest do
  use BookselfWeb.ConnCase, async: true

  import Bookself.Factory

  setup do
    user = insert(:user)
    token = BookselfWeb.Authentication.sign_user(user)

    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn, user: user}
  end

  @query """
  mutation ($input: ProfileInput) {
    updateProfile(input: $input) {
      errors { key, message }
      user {
        name
        email
      }
    }
  }
  """
  test "update the current user profile", %{conn: conn, user: user} do
    options = %{
      query: @query,
      variables: %{
        input: %{
          name: "Updated User",
        }
      }
    }

    response = post(conn, "/graphql", options)

    assert json_response(response, 200) == %{
      "data" => %{
        "updateProfile" => %{
          "errors" => nil,
          "user" => %{
            "email" => user.email,
            "name" => "Updated User"
          }
        }
      }
    }
  end

  test "returns errors when input is invalid", %{conn: conn} do
    options = %{
      query: @query,
      variables: %{
        input: %{
          name: "Updated User",
          password: "12345678",
          password_confirmation: "87654321"
        }
      }
    }

    response = post(conn, "/graphql", options)

    assert json_response(response, 200) == %{
      "data" => %{
        "updateProfile" => %{
          "errors" => [
            %{
              "key" => "password_confirmation",
              "message" => "does not match confirmation"
            }
          ],
          "user" => nil
        }
      }
    }
  end
end
