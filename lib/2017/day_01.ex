defmodule AdventOfCode.Y2017.Day01 do
  defp prepare_input(raw),
    do: raw |> String.trim() |> String.graphemes() |> Enum.map(&String.to_integer/1)

  def part1(args) do
    input = prepare_input(args)

    (input ++ [hd(input)])
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.filter(&match?([a, a], &1))
    |> Enum.map(&hd(&1))
    |> Enum.sum()
  end

  def part2(args) do
    input = prepare_input(args)
    offset = div(length(input), 2)

    input
    |> Enum.with_index()
    |> Enum.filter(fn {n, idx} ->
      pos = rem(idx + offset, length(input))
      Enum.at(input, pos) == n
    end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end
end
