defmodule Bookself.LibraryFactory do
  @moduledoc """
  Factory to create a new library.

      import Bookself.Factory

      library = insert(:library, user_id: user.id)
  """

  defmacro __using__(_opts) do
    quote do
      def library_factory do
        %Bookself.Libraries.Library{
          user: build(:user),
          name: "Library"
        }
      end
    end
  end
end
