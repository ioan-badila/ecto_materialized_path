defmodule EctoMaterializedPath.Path do
  @behaviour Ecto.Type

  @moduledoc """
  Right now it's implemented absolutely the same as {:array, integer|binary}
  But things can change later
  """

  def cast(list) when is_list(list) do
    if valid?(list) do
      {:ok, list}
    else
      :error
    end
  end

  def cast(_), do: :error

  def dump(value), do: {:ok, value}

  def load(value), do: {:ok, value}

  def type, do: EctoMaterializedPath.Path

  defp valid?([]), do: true

  defp valid?([head | tail]) do
    case id_type(head) do
      :unsupported -> false
      type -> Enum.all?(tail, &(type == id_type(&1)))
    end
  end

  defp id_type(id) when is_binary(id), do: :binary
  defp id_type(id) when is_integer(id), do: :integer
  defp id_type(_), do: :unsupported
end
