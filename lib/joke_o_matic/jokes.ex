defmodule JokeOMatic.Jokes do
  alias JokeOMatic.{Joke}

  use GenServer
  @name __MODULE__

  ### Client
  def start_link()

  def start_link(opts \\ %{}) do
    GenServer.start_link(__MODULE__, opts, name: @name)
  end

  def populate(count \\ 10) do
    Enum.each(1..count, fn _i ->
      spawn(fn -> add(Joke.random()) end)
    end)
  end

  def list_all() do
    GenServer.call(@name, :list)
  end

  def add(joke) do
    GenServer.cast(@name, {:add, joke})
  end

  def flush() do
    GenServer.cast(@name, {:flush})
  end

  ### Server(callbacks)
  def init(jokes) do
    spawn_link(fn -> populate() end)
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
