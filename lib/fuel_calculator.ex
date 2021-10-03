defmodule FuelCalculator do
  @moduledoc """
  Documentation for `FuelCalculator`.
  """

  @spec calculate(Integer.t(), List.t()) :: Integer.t()
  def calculate(mass, route) do
    case validate(route) do
      :ok -> Enum.reverse(route) |> calculate(mass, 0)
      err -> err
    end
  end

  defp calculate([path | tail], mass, fuel_acc) do
    path_fuel =
      (mass + fuel_acc)
      |> calculate_path(path)

    fuel_acc = fuel_acc + path_fuel
    calculate(tail, mass, fuel_acc)
  end

  defp calculate([], _, fuel_acc), do: fuel_acc

  defp calculate_path(mass, path), do: calculate_path(mass, path, 0)
  defp calculate_path(mass, _, fuel_acc) when mass <= 0, do: fuel_acc - mass   # for the sake of tail recursive
  defp calculate_path(mass, path, fuel_acc) do
    mass = fuel(mass, path)
    fuel_acc = fuel_acc + mass
    calculate_path(mass, path, fuel_acc)
  end

  defp fuel(mass, {:launch, gravity}) do
    (mass * gravity * 0.042 - 33) |> floor()
  end

  defp fuel(mass, {:land, gravity}) do
    (mass * gravity * 0.033 - 42) |> floor()
  end

  defp validate(route) do
    Enum.map(route, fn {direction, _} -> direction end)
    |> validate_direction_and_path()
  end

  defp validate_direction_and_path([:land | [:land | _]]), do: {:error, "Invalid path"}
  defp validate_direction_and_path([:launch | [:launch | _]]), do: {:error, "Invalid path"}
  defp validate_direction_and_path([:launch | tail]), do: validate_direction_and_path(tail)
  defp validate_direction_and_path([:land | tail]), do: validate_direction_and_path(tail)
  defp validate_direction_and_path([_ | _]), do: {:error, "Invalid direction"}
  defp validate_direction_and_path(_), do: :ok
end
