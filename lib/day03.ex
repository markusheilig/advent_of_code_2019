defmodule Day03.Wire do
  import String, only: [to_integer: 1]
  import Enum, only: [map: 2, min: 1]

  def nearest_intersection(wire1, wire2) do
    wire1
    |> path()
    |> intersection(path(wire2))
    |> map(&to_manhattan_distance/1)
    |> min()
  end

  def nearest_intersection_steps(wire1, wire2) do
    path_wire1 = path(wire1)
    path_wire2 = path(wire2)

    distances =
      for pos <- intersection(path_wire1, path_wire2) do
        d1 = Map.get(path_wire1, pos)
        d2 = Map.get(path_wire2, pos)
        d1 + d2
      end
    Enum.min(distances)
  end

  defp path(wire) do
    wire
    |> String.split(",")
    |> Enum.map(&to_steps/1)
    |> Enum.reduce({_start_position = {0, 0}, _path = %{}}, &walk/2)
    |> elem(1)
  end

  defp to_steps("R" <> steps), do: {{1, 0}, to_integer(steps)}
  defp to_steps("L" <> steps), do: {{-1, 0}, to_integer(steps)}
  defp to_steps("U" <> steps), do: {{0, 1}, to_integer(steps)}
  defp to_steps("D" <> steps), do: {{0, -1}, to_integer(steps)}

  defp walk({direction, steps}, {position, path}) do
    {x, y} = position
    {d1, d2} = direction

    new_path =
      for step <- 1..steps, into: %{} do
        coordinate = {x + d1 * step, y + d2 * step}
        index = map_size(path) + step
        {coordinate, index}
      end

    position = {x + d1 * steps, y + d2 * steps}
    path = Map.merge(path, new_path)
    {position, path}
  end

  defp to_manhattan_distance({x, y}), do: abs(x) + abs(y)

  defp intersection(xs, ys) do
    xs = Map.keys(xs) |> MapSet.new()
    ys = Map.keys(ys) |> MapSet.new()
    MapSet.intersection(xs, ys)
  end
end
