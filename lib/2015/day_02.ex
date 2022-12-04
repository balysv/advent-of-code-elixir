defmodule AdventOfCode.Y2015.Day02 do
  defp prepare_input(raw_input) do
    raw_input
    |> String.split(["\n", "x"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3)
  end

  defp area([l, w, h]) do
    sides = [l * w, w * h, h * l]
    smallest = Enum.min(sides)
    2 * Enum.sum(sides) + smallest
  end

  defp ribbon(dims = [l, w, h]) do
    [d1, d2] = Enum.sort(dims) |> Enum.take(2)
    volume = l * w * h
    2 * (d1 + d2) + volume
  end

  def part1(args), do: args |> prepare_input() |> Enum.map(&area/1) |> Enum.sum()
  def part2(args), do: args |> prepare_input() |> Enum.map(&ribbon/1) |> Enum.sum()
end
