defmodule Day02Test do
  use ExUnit.Case

  alias Day02.IntMachine

  test "it adds two values given op code 1" do
    assert IntMachine.exec_program("1,0,0,0,99") == "2,0,0,0,99"
  end

  test "it multiplies two values given op code 2" do
    assert IntMachine.exec_program("2,3,0,3,99") == "2,3,0,6,99"
    assert IntMachine.exec_program("2,4,4,5,99,0") == "2,4,4,5,99,9801"
  end

  test "it halts when it reached op code 99" do
    assert IntMachine.exec_program("1,1,1,4,99,5,6,0,99") == "30,1,1,4,2,5,6,0,99"
  end

end
