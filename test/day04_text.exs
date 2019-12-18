defmodule Day04Test do
  use ExUnit.Case

  alias Day04.PasswordValidator

  test "six-digit number" do
    refute PasswordValidator.valid?("12345")
    refute PasswordValidator.valid?("1234567")
    assert PasswordValidator.valid?("112233")
  end

  test "digits never decrease going from left to right" do
    refute PasswordValidator.valid?("123451")
    assert PasswordValidator.valid?("111111")
  end

  test "(at least) two adjacent digits are the same" do
    refute PasswordValidator.valid?("123456")
    assert PasswordValidator.valid?("123446")
  end

  test "part 1" do
    IO.puts(PasswordValidator.part1(134_564, 585_159))
  end
end
