defmodule Day03.Wire do
  import String, only: [to_integer: 1]
  import MapSet, only: [intersection: 2]
  import Enum, only: [map: 2, min: 1]

  def nearest_intersection(wire1, wire2) do
    wire1
    |> coordinates()
    |> intersection(coordinates(wire2))
    |> map(&to_manhattan_distance/1)
    |> min()
  end

  defp coordinates(wire) do
    wire
    |> String.split(",")
    |> Enum.map(&to_steps/1)
    |> Enum.reduce({_start_position = {0, 0}, _coordinates = MapSet.new()}, &walk/2)
    |> elem(1)
  end

  defp to_steps("R" <> steps), do: {{1, 0}, to_integer(steps)}
  defp to_steps("L" <> steps), do: {{-1, 0}, to_integer(steps)}
  defp to_steps("U" <> steps), do: {{0, 1}, to_integer(steps)}
  defp to_steps("D" <> steps), do: {{0, -1}, to_integer(steps)}

  defp walk({direction, steps}, {position, coordinates}) do
    {x, y} = position
    {d1, d2} = direction
    new_coordinates = for step <- 1..steps, into: MapSet.new(), do: {x + d1 * step, y + d2 * step}
    position = {x + d1 * steps, y + d2 * steps}
    coordinates = MapSet.union(coordinates, new_coordinates)
    {position, coordinates}
  end

  defp to_manhattan_distance({x, y}), do: abs(x) + abs(y)
end
