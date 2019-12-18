defmodule Day03.Wire do
  import String, only: [to_integer: 1]
  import Enum, only: [map: 2, min: 1]

  def nearest_intersection(wire1, wire2) do
    wire1
    |> path()
    |> intersection(path(wire2))
    |> map(&manhattan_distance/1)
    |> min()
  end

  def nearest_intersection_steps(wire1, wire2) do
    path1 = path(wire1)
    path2 = path(wire2)

    intersection_steps =
      for pos <- intersection(path1, path2) do
        steps1 = Enum.find_index(path1, &(&1 == pos)) + 1
        steps2 = Enum.find_index(path2, &(&1 == pos)) + 1
        steps1 + steps2
    end

    Enum.min(intersection_steps)
  end

  def path(wire) do
    wire
    |> to_steps()
    |> walk()
  end

  defp to_steps(wire) do
    wire
    |> String.split(",")
    |> Enum.map(fn
      "R" <> num -> {{1,0}, to_integer(num)}
      "L" <> num -> {{-1, 0}, to_integer(num)}
      "U" <> num -> {{0, 1}, to_integer(num)}
      "D" <> num -> {{0, -1}, to_integer(num)}
    end)
  end

  defp walk(way, pos \\ {0, 0}, path \\ [])

  defp walk(_steps = [], _pos, path), do: Enum.reverse(path)

  defp walk([{_direction, 0} | steps], pos, path), do: walk(steps, pos, path)

  defp walk([{direction, num} | steps], {x, y}, path) do
    {dx, dy} = direction
    pos = {x + dx, y + dy}
    walk([{direction, num - 1} | steps], pos, [pos | path])
  end

  defp manhattan_distance({x, y}), do: abs(x) + abs(y)

  defp intersection(path1, path2) do
    coordinates1 = MapSet.new(path1)
    coordinates2 = MapSet.new(path2)
    MapSet.intersection(coordinates1, coordinates2)
  end

end
