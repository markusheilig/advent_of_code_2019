defmodule Day03.Wire do
  import String, only: [to_integer: 1]
  import Enum, only: [map: 2, min: 1]

  def nearest_intersection(wire1, wire2) do
    wire1
    |> coordinates()
    |> intersection(coordinates(wire2))
    |> map(&to_manhattan_distance/1)
    |> min()
  end

  def nearest_intersection_steps(wire1, wire2) do
    wire1_coordinates = coordinates(wire1)
    wire2_coordinates = coordinates(wire2)

    intersection_steps =
      for pos <- intersection(wire1_coordinates, wire2_coordinates) do
        wire1_steps = Map.get(wire1_coordinates, pos)
        wire2_steps = Map.get(wire2_coordinates, pos)
        wire1_steps + wire2_steps
      end
    Enum.min(intersection_steps)
  end

  defp coordinates(wire) do
    wire
    |> String.split(",")
    |> Enum.map(&to_steps/1)
    |> Enum.reduce({_start_position = {0, 0}, _coordinates_and_index = %{}}, &walk/2)
    |> elem(1)
  end

  defp to_steps("R" <> steps), do: {{1, 0}, to_integer(steps)}
  defp to_steps("L" <> steps), do: {{-1, 0}, to_integer(steps)}
  defp to_steps("U" <> steps), do: {{0, 1}, to_integer(steps)}
  defp to_steps("D" <> steps), do: {{0, -1}, to_integer(steps)}

  defp walk({direction, steps}, {position, coordinates}) do
    {x, y} = position
    {d1, d2} = direction

    new_coordinates =
      for step <- 1..steps, into: %{} do
        coordinate = {x + d1 * step, y + d2 * step}
        index = map_size(coordinates) + step
        {coordinate, index}
      end

    position = {x + d1 * steps, y + d2 * steps}
    coordinates = Map.merge(coordinates, new_coordinates)
    {position, coordinates}
  end

  defp to_manhattan_distance({x, y}), do: abs(x) + abs(y)

  defp intersection(xs, ys) do
    xs = Map.keys(xs) |> MapSet.new()
    ys = Map.keys(ys) |> MapSet.new()
    MapSet.intersection(xs, ys)
  end
end
