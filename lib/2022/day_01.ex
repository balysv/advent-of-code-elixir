defmodule AdventOfCode.Y2022.Day01 do
  defp prepare_input(raw_input) do
    raw_input
    |> String.split("\n")
    |> Enum.reduce({0, []}, fn
      "", {curr, acc} -> {0, [curr | acc]}
      i, {curr, acc} -> {String.to_integer(i) + curr, acc}
    end)
    |> elem(1)
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.max()
  end

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end
end
