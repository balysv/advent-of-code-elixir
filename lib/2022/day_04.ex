defmodule AdventOfCode.Y2022.Day04 do
  defp prepare_input(raw) do
    raw
    |> String.split(["\n", "-", ","], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(4)
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.filter(fn [s1, e1, s2, e2] ->
      (s1 <= s2 and e1 >= e2) or (s2 <= s1 and e2 >= e1)
    end)
    |> Enum.count()
  end

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.filter(fn [s1, e1, s2, e2] ->
      s1 in s2..e2 or e1 in s2..e2 or
        s2 in s1..e1 or e2 in s1..e1
    end)
    |> Enum.count()
  end
end
