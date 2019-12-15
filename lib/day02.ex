defmodule Day02.IntMachine do

  @op_code_sum 1
  @op_code_mul 2
  @halt 99

  def exec_program(program) when is_binary(program) do
    program
    |> extract()
    |> exec()
    |> to_str()
  end

  def restore_gravity_assist(program) when is_binary(program) do
    program
    |> extract()
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> to_str()
  end

  defp extract(input) do
    input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
  end

  defp to_str(program), do: Enum.join(program, ",")

  defp exec(program, state \\ :continue, instruction_pointer \\ 0)

  defp exec(program, :continue, instruction_pointer) do
    opcode = Enum.at(program, instruction_pointer)
    {new_state, new_program} = exec(opcode, program, instruction_pointer)
    exec(new_program, new_state, instruction_pointer + 4)
  end

  defp exec(program, :halt, _instruction_pointer), do: program

  defp exec(@halt, program, _instruction_pointer), do: {:halt, program}

  defp exec(@op_code_sum, program, instruction_pointer) do
    {param1, param2, pos} = extract_parameters(program, instruction_pointer)
    new_program = List.replace_at(program, pos, param1 + param2)
    {:continue, new_program}
  end

  defp exec(@op_code_mul, program, instruction_pointer) do
    {param1, param2, pos} = extract_parameters(program, instruction_pointer)
    new_program = List.replace_at(program, pos, param1 * param2)
    {:continue, new_program}
  end

  defp extract_parameters(program, instruction_pointer) do
    [param1_pos, param2_pos, pos] = Enum.slice(program, instruction_pointer + 1, 3)
    param1 = Enum.at(program, param1_pos)
    param2 = Enum.at(program, param2_pos)
    {param1, param2, pos}
  end

end
