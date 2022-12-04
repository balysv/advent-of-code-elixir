defmodule AdventOfCode.Y2017.Day02 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn s -> String.split(s, "\t") |> Enum.map(&String.to_integer/1) end)
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.map(&Enum.min_max/1)
    |> Enum.map(fn {min, max} -> max - min end)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.map(fn nums -> hd(for a <- nums, b <- nums, a != b, rem(a, b) == 0, do: div(a, b)) end)
    |> Enum.sum()
  end
end
