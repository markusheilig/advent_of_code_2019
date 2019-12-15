defmodule Day02.IntMachine do
  @op_code_sum 1
  @op_code_mul 2
  @op_code_halt 99

  import List, only: [replace_at: 3]

  def execute(program) when is_binary(program) do
    program
    |> parse()
    |> exec()
  end

  def find_nouns_and_verbs_for_return_code(program, return_code) when is_binary(program) and is_number(return_code) do
    candidates = 0..99

    for noun <- candidates,
        verb <- candidates,
        program = parse(program),
        program = replace_at(program, 1, noun),
        program = replace_at(program, 2, verb),
        exec(program) == return_code do
      {noun, verb}
    end
  end

  defp parse(program) do
    program
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp exec(program, state \\ :continue, ip \\ 0)

  defp exec(program, :halt, _ip), do: program |> hd()

  defp exec(program, :continue, ip) do
    opcode = Enum.at(program, ip)
    {new_state, new_program} = exec(opcode, program, ip)
    exec(new_program, new_state, ip + 4)
  end

  defp exec(@op_code_halt, program, _ip), do: {:halt, program}

  defp exec(@op_code_sum, program, ip), do: continue_apply_fn2(program, ip, &(&1 + &2))

  defp exec(@op_code_mul, program, ip), do: continue_apply_fn2(program, ip, &(&1 * &2))

  defp continue_apply_fn2(program, ip, fn2) do
    [param1_pos, param2_pos, pos] = Enum.slice(program, ip + 1, 3)
    param1 = Enum.at(program, param1_pos)
    param2 = Enum.at(program, param2_pos)
    new_program = List.replace_at(program, pos, fn2.(param1, param2))
    {:continue, new_program}
  end

end
