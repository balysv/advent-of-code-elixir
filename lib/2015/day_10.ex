defmodule AdventOfCode.Y2015.Day10 do
  def part1(args) do
    1..40
    |> Enum.reduce(args, fn _, input -> recur(input) end)
    |> String.length()
  end

  def part2(args) do
    1..50
    |> Enum.reduce(args, fn _, input -> recur(input) end)
    |> String.length()
  end

  defp recur(input), do: recur(String.graphemes(input), nil, 0, "")

  defp recur([], prev, count, acc), do: acc <> "#{count + 1}#{prev}"

  defp recur([digit | rest], prev, count, acc) do
    if digit == prev do
      recur(rest, prev, count + 1, acc)
    else
      acc = if prev != nil, do: acc <> "#{count + 1}#{prev}", else: acc
      recur(rest, digit, 0, acc)
    end
  end
end
