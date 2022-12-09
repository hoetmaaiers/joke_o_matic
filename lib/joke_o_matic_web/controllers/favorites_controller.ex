defmodule JokeOMaticWeb.FavoritesController do
  alias JokeOMatic.{Jokes, Favorites}
  use JokeOMaticWeb, :controller

  def index(conn, params) do
    %{"user_id" => user_id} = params
    Favorites.start_link(user_id)

    favorites =
      Favorites.list_all(user_id) |> Enum.map(fn favorite_id -> Jokes.get_by_id(favorite_id) end)

    render(conn, "index.json", favorites: favorites)
  end

  def create(conn, params) do
    %{"user_id" => user_id, "joke_id" => joke_id} = params

    Favorites.start_link(user_id)
    Favorites.add(user_id, joke_id)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(201, "")
  end
end
