defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @now NaiveDateTime.local_now()
  @enforce_keys @keys
  defstruct @keys

  def build(
        # it will come in a valid format
        complete_date: date_string,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_id
      ) do
    case verify_date(date_string) do
      :valid ->
        {:ok,
         %__MODULE__{
           complete_date: date_string,
           local_origin: local_origin,
           local_destination: local_destination,
           user_id: user_id,
           id: 0
         }}

      :invalid ->
        {:error, "Please choose a valid date/time"}
    end
  end

  def verify_date(date_string) do
    range = NaiveDateTime.diff(date_string, @now, :second)

    if range >= 60 do
      :valid
    else
      :invalid
    end
  end
end
