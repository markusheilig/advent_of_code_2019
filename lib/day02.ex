defmodule Day02.IntMachine do
  @op_code_sum 1
  @op_code_mul 2
  @op_code_halt 99
  @separator ","

  def execute(program) when is_binary(program) do
    program
    |> binary_to_program()
    |> exec()
    |> to_str()
  end

  def restore(program, noun \\ 12, verb \\ 2) when is_binary(program) do
    program
    |> binary_to_program()
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
    |> to_str()
  end

  def find_nouns_and_verbs_for_value(program, value_to_look_for) do
    candidates = 0..99
    for noun <- candidates,
        verb <- candidates,
        program = restore(program, noun, verb),
        program = execute(program),
        program_starts_with?(program, value_to_look_for) do
      {noun, verb}
    end
  end

  defp program_starts_with?(program, value), do: String.starts_with?(program, to_string(value) <> @separator)

  defp binary_to_program(input) do
    input
    |> String.split(@separator)
    |> Enum.map(&String.to_integer/1)
  end

  defp to_str(program), do: Enum.join(program, @separator)

  defp exec(program, state \\ :continue, instruction_pointer \\ 0)

  defp exec(program, :continue, instruction_pointer) do
    opcode = Enum.at(program, instruction_pointer)
    {new_state, new_program} = exec(opcode, program, instruction_pointer)
    exec(new_program, new_state, instruction_pointer + 4)
  end

  defp exec(program, :halt, _instruction_pointer), do: program

  defp exec(@op_code_halt, program, _instruction_pointer), do: {:halt, program}

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
