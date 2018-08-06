defmodule Bookself.UserFactory do
  @moduledoc """
  Factory to create a new user.

      import Bookself.Factory

      user = insert(:user)
  """

  defmacro __using__(_opts) do
    quote do
      def user_factory(password \\ "12345678") do
        email = sequence(:email, &"user#{&1}@test.com")

        %Bookself.Accounts.User{
          email: email,
          name: "User",
          password: password
        }
      end
    end
  end
end
