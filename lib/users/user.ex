defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(name, email, cpf, id) when is_bitstring(cpf) do
    {:ok,
     %__MODULE__{
       name: name,
       email: email,
       cpf: cpf,
       id: id
     }}
  end

  def build do
    {:error, "Cpf must be a String"}
  end
end
