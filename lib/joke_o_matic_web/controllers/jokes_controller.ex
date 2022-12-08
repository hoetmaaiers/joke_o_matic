defmodule JokeOMaticWeb.JokesController do
  alias JokeOMatic.Jokes
  use JokeOMaticWeb, :controller

  def index(conn, _params) do
    jokes = Jokes.list_all()
    render(conn, "index.json", jokes: jokes)
  end
end
