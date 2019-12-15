defmodule Day01.Spacecraft do
  def calc(masses, strategy) when is_binary(masses) do
    masses
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> strategy.()
  end

  def sum(masses, strategy) when is_list(masses) do
    Enum.reduce(masses, 0, fn mass, sum -> sum + strategy.(mass) end)
  end

  def fuel(module_masses) when is_list(module_masses), do: sum(module_masses, &fuel/1)
  def fuel(module_mass) when is_number(module_mass), do: Integer.floor_div(module_mass, 3) - 2

  def fuel_recursive(masses) when is_list(masses), do: sum(masses, &fuel_recursive/1)
  def fuel_recursive(mass) when is_number(mass), do: fuel_recursive(mass, _acc = 0)

  defp fuel_recursive(mass, acc) do
    fuel = fuel(mass)

    if fuel <= 0 do
      acc
    else
      fuel_recursive(fuel, acc + fuel)
    end
  end
end
