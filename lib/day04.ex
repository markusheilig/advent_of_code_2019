defmodule Day04.PasswordValidator do
  def part1(from, to) do
    from..to
    |> Enum.map(&Integer.to_string/1)
    |> Enum.filter(&valid?/1)
    |> Enum.count()
  end

  def valid?(input) do
    with pwd = to_int_list(input),
         :ok <- length_of_six(pwd),
         :ok <- digits_never_decrease(pwd),
         :ok <- two_same_adjacent_digits(pwd) do
      true
    else
      _reason -> false
    end
  end

  defp to_int_list(str), do: str |> String.codepoints() |> Enum.map(&String.to_integer/1)

  defp length_of_six(pwd) when length(pwd) == 6, do: :ok
  defp length_of_six(_), do: :invalid_length

  defp digits_never_decrease([]), do: :ok
  defp digits_never_decrease([_]), do: :ok
  defp digits_never_decrease([a, b | rest]) when a <= b, do: digits_never_decrease([b | rest])
  defp digits_never_decrease(_), do: :decreasing_digit

  defp two_same_adjacent_digits([a, a | _]), do: :ok
  defp two_same_adjacent_digits([_, b | rest]), do: two_same_adjacent_digits([b | rest])
  defp two_same_adjacent_digits([]), do: :no_same_adjacent_digits
  defp two_same_adjacent_digits([_]), do: :no_same_adjacent_digits
end
