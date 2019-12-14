defmodule Day02.IntMachine do

  @op_code_sum 1
  @op_code_mul 2
  @halt 99

  def exec_program(input) do
    input
    |> extract_program()
    |> exec()
    |> to_str()
  end

  def restore_gravity_assist(input) do
    input
    |> extract_program()
    |> List.update_at(1, fn _value_before -> 12 end)
    |> List.update_at(2, fn _value_before -> 2 end)
    |> to_str()
  end

  defp extract_program(input) do
    input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
  end

  defp to_str(program), do: Enum.join(program, ",")

  defp exec(program, state \\ :continue, offset \\ 0)

  defp exec(program, :continue, offset) do
    opcode = Enum.at(program, offset)
    {new_state, new_program} = exec(opcode, program, offset)
    exec(new_program, new_state, offset + 4)
  end

  defp exec(program, :halt, _offset), do: program

  defp exec(@halt, program, _offset), do: {:halt, program}

  defp exec(@op_code_sum, program, offset) do
    {op1, op2, pos} = extract_operands(program, offset)
    new_program = List.replace_at(program, pos, op1 + op2)
    {:continue, new_program}
  end

  defp exec(@op_code_mul, program, offset) do
    {op1, op2, pos} = extract_operands(program, offset)
    new_program = List.replace_at(program, pos, op1 * op2)
    {:continue, new_program}
  end

  defp extract_operands(program, offset) do
    operand1_pos = Enum.at(program, offset + 1)
    operand1 = Enum.at(program, operand1_pos)
    operand2_pos = Enum.at(program, offset + 2)
    operand2 = Enum.at(program, operand2_pos)
    pos = Enum.at(program, offset + 3)
    {operand1, operand2, pos}
  end

end
