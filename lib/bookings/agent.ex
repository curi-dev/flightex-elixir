defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking) do
    uuid = UUID.uuid4()

    Agent.update(__MODULE__, fn state -> update_state(state, uuid, booking) end)

    {:ok, uuid}
  end

  def get(id) do
    Agent.get(__MODULE__, fn state -> get_booking_by_id(state, id) end)
  end

  def get_booking_by_id(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end

  def update_state(state, uuid, booking) do
    Map.put(state, uuid, booking)
  end
end
