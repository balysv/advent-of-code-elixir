defmodule AdventOfCode.Y2022.Day10 do
  defp prepare_input(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.reduce([{1, 1}], fn
      "noop", [{c, x} | _] = cycles ->
        [{c + 1, x} | cycles]

      "addx " <> v, [{c, x} | _] = cycles ->
        v = String.to_integer(v)
        [{c + 2, x + v}, {c + 1, x} | cycles]
    end)
    |> Enum.drop(1)
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.filter(fn {c, _} -> c in [20, 60, 100, 140, 180, 220] end)
    |> Enum.map(&Tuple.product/1)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.reverse()
    |> Enum.map(fn {c, x} ->
      pos = rem(c - 1, 40)
      if abs(pos - x) <= 1, do: "#", else: "."
    end)
    |> Enum.chunk_every(40)
    |> Enum.map(&Enum.join/1)
    |> Enum.each(&IO.puts/1)
  end
end
