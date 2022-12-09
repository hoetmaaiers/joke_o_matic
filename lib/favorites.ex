defmodule JokeOMatic.Favorites do
  alias JokeOMatic.{FavoritesRegistry}

  use GenServer

  defmodule State do
    @enforce_keys ~w[joke_ids]a
    defstruct joke_ids: []
  end

  def via_tuple(id) do
    FavoritesRegistry.via_tuple({__MODULE__, id})
  end

  def whereis(id) do
    case FavoritesRegistry.whereis_name({__MODULE__, id}) do
      :undefined -> nil
      pid -> pid
    end
  end

  ### Client
  def start_link(id) do
    state = %State{joke_ids: []}
    GenServer.start_link(__MODULE__, state, name: via_tuple(id))
  end

  def list_all(id) do
    favorites = GenServer.call(via_tuple(id), :list)
    favorites
  end

  def add(id, joke_id) do
    GenServer.cast(via_tuple(id), {:add, joke_id})
  end

  ### Server ( callbacks )
  def init(state) do
    {:ok, state}
  end

  def handle_call(:list, _from, state) do
    {:reply, state.joke_ids, state}
  end

  def handle_cast({:add, joke_id}, state) do
    new_state = Map.update!(state, :joke_ids, fn joke_ids -> [joke_id | joke_ids] end)
    {:noreply, new_state}
  end
end
