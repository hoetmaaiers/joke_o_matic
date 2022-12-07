defmodule JokeOMatic.Joke do
  alias JokeOMatic.Joke

  defstruct [:id, :name]

  def random() do
    %{body: joke} = HTTPoison.get!("https://api.chucknorris.io/jokes/random")

    case joke |> Jason.decode() do
      {:ok, decoded} ->
        %Joke{
          id: decoded["id"],
          name: decoded["value"]
        }
    end
  end
end
