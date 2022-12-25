defmodule AdventOfCode.Y2022.Day25 do
  defp to_number("-"), do: -1
  defp to_number("="), do: -2
  defp to_number(no), do: String.to_integer(no)

  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn snafu ->
      snafu
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn
        {c, 0} -> to_number(c)
        {c, idx} -> floor(:math.pow(5, idx) * to_number(c))
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
    |> to_snafu()
  end

  defp to_snafu(no) when no > 2 do
    {carry, c} =
      case rem(no, 5) do
        0 -> {0, "0"}
        1 -> {0, "1"}
        2 -> {0, "2"}
        3 -> {1, "="}
        4 -> {1, "-"}
      end

    to_snafu(div(no, 5) + carry) <> c
  end

  defp to_snafu(i), do: "#{i}"
end
