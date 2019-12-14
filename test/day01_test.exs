defmodule Day01Test do
  use ExUnit.Case

  alias Day01.Spacecraft

  test "calculates the fuel for a single spacecraft module based on the module's mass" do
    assert Spacecraft.fuel(_module_mass = 12) == 2
    assert Spacecraft.fuel(_module_mass = 14) == 2
    assert Spacecraft.fuel(_module_mass = 1969) == 654
    assert Spacecraft.fuel(_module_mass = 100756) == 33583
  end

  test "calculates the fuel for a collection of modules" do
    assert Spacecraft.fuel([]) == 0
    assert Spacecraft.fuel([12]) == 2
    assert Spacecraft.fuel([12, 14]) == 2 + 2
    assert Spacecraft.fuel([12, 14, 1969]) == 2 + 2 + 654
    assert Spacecraft.fuel([12, 14, 1969, 100756]) == 2 + 2 + 654 + 33583
  end

  test "calculates the fuel from a given text" do
    text = """
      12
      14
      1969
      100756
    """
    assert Spacecraft.calc(text, _strategy = &Spacecraft.fuel/1) == 2 + 2 + 654 + 33583
  end

  test "fuel has a weight and thus also needs fuel" do
    assert Spacecraft.fuel_recursive(1969) == 654 + 216 + 70 + 21 + 5
    assert Spacecraft.fuel_recursive(100756) == 33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2
  end

  test "calculates recursive fuel from a given text" do
    text = """
      1969
      100756
    """
    assert Spacecraft.calc(text, _strategy = &Spacecraft.fuel_recursive/1) == 51312
  end

end
