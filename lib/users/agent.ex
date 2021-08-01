defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{cpf: cpf} = user) do
    Agent.update(__MODULE__, &update_state(&1, cpf, user))

    {:ok, user}
  end

  def get_all() do
    Agent.get(__MODULE__, & &1)
  end

  def get(cpf) do
    Agent.get(__MODULE__, fn state -> get_user_by_id(state, cpf) end)
  end

  defp get_user_by_id(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def update_state(state, cpf, user) do
    Map.put(state, cpf, user)
  end
end
