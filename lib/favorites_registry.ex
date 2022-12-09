# inspiration from 4. 🙏: https://dev.to/mnishiguchi/elixir-genserver-process-management-registry-334c
defmodule JokeOMatic.FavoritesRegistry do
  def via_tuple(key) when is_tuple(key) do
    {:via, Registry, {__MODULE__, key}}
  end

  def whereis_name(key) when is_tuple(key) do
    Registry.whereis_name({__MODULE__, key})
  end

  def start() do
    Registry.start_link(keys: :unique, name: __MODULE__)
  end
end
