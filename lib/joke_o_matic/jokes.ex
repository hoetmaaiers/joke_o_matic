defmodule JokeOMatic.Jokes do
  use GenServer

  ### Client
  def populate(pid, count \\ 10) do
    Enum.each(1..count, fn _i ->
      spawn(fn -> add(pid, Joke.random()) end)
    end)
  end

  def list_all(pid) do
    GenServer.call(pid, :list)
  end

  def add(pid, joke) do
    GenServer.cast(pid, {:add, joke})
  end

  def flush(pid) do
    GenServer.cast(pid, {:flush})
  end

  ### Server(callbacks)
  def init(jokes) do
    {:ok, jokes}
  end

  def handle_call(:list, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:add, joke}, state) do
    {:noreply, [joke | state]}
  end

  def handle_cast({:flush}, _state) do
    {:noreply, []}
  end
end
