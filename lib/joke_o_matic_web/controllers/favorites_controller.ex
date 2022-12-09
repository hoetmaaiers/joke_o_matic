defmodule JokeOMaticWeb.FavoritesController do
  alias JokeOMatic.{Jokes, Favorites}
  use JokeOMaticWeb, :controller

  def index(conn, params) do
    %{"user_id" => user_id} = params
    Favorites.start_link(user_id)

    # random_joke = random_string()
    # Favorites.add(user_id, random_joke)

    favorites =
      Favorites.list_all(user_id) |> Enum.map(fn favorite_id -> Jokes.get_by_id(favorite_id) end)

    IO.inspect(favorites)
    render(conn, "index.json", favorites: favorites)
  end

  defp random_string do
    for _ <- 1..10, into: "", do: <<Enum.random('0123456789abcdef')>>
  end
end
