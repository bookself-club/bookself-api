defmodule BookselfWeb.GraphQL.Accounts.Mutation.RegistrationTest do
  use BookselfWeb.ConnCase, async: true

  @query """
  mutation ($input: RegistrationInput) {
    registration(input: $input) {
      errors {
        key
        message
      }
      session {
        token
        user {
          email
          name
        }
      }
    }
  }
  """
  test "registrate a new user" do
    options = %{
      query: @query,
      variables: %{
        input: %{
          name: "New User",
          email: "new_user@test.com",
          password: "12345678",
          password_confirmation: "12345678"
        }
      }
    }

    response =
      build_conn()
      |> post("/graphql", options)

    assert %{
      "data" => %{
        "registration" => %{
          "errors" => nil,
          "session" => %{
            "token" => token,
            "user" => %{
              "email" => "new_user@test.com",
              "name" => "New User"
            }
          }
        }
      }
    } = json_response(response, 200)

    assert {:ok, %{email: "new_user@test.com", name: "New User"}} ==
      BookselfWeb.Authentication.verify_token(token)
  end

  test "returns errors when input is invalid" do
    options = %{
      query: @query,
      variables: %{
        input: %{
          name: "New User",
          email: "new_user@test.com",
          password: "12345678",
          password_confirmation: "87654321"
        }
      }
    }

    response =
      build_conn()
      |> post("/graphql", options)

    assert json_response(response, 200) == %{
      "data" => %{
        "registration" => %{
          "errors" => [
            %{
              "key" => "password_confirmation",
              "message" => "does not match confirmation"
            }
          ],
          "session" => nil
        }
      }
    }
  end
end
