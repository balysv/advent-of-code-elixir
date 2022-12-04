defmodule AdventOfCode.Y2015.Day01 do
  defmodule P1 do
    def process(input), do: process(input, 0)
    defp process("", acc), do: acc
    defp process("(" <> rest, acc), do: process(rest, acc + 1)
    defp process(")" <> rest, acc), do: process(rest, acc - 1)
  end

  defmodule P2 do
    def process(input), do: process(input, 0, 0)
    defp process(rest, pos, -1), do: pos
    defp process("", _, acc), do: acc
    defp process("(" <> rest, pos, acc), do: process(rest, pos + 1, acc + 1)
    defp process(")" <> rest, pos, acc), do: process(rest, pos + 1, acc - 1)
  end

  def part1(args) do
    args |> String.trim() |> P1.process()
  end

  def part2(args) do
    args |> String.trim() |> P2.process()
  end
end
