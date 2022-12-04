defmodule AdventOfCode.Y2016.Day03 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn s -> String.split(s, " ", trim: true) |> Enum.map(&String.to_integer/1) end)
  end

  def part1(args) do
    args
    |> prepare_input
    |> Enum.filter(&right?/1)
    |> Enum.count()
  end

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.zip/1)
    |> List.flatten()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.filter(&right?/1)
    |> Enum.count()
  end

  defp right?([a, b, c]), do: a + b > c and a + c > b and b + c > a
end
