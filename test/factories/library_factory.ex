defmodule Bookself.LibraryFactory do
  @moduledoc """
  Factory to create a new user.

      import Bookself.Factory

      library = insert(:library, user_id: user.id)
  """

  defmacro __using__(_opts) do
    quote do
      def library_factory do
        %Bookself.Libraries.Library{
          name: "Library"
        }
      end
    end
  end
end
