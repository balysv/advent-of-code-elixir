defmodule AdventOfCode.Y2017.Day03 do
  defp input(raw), do: raw |> String.trim() |> String.to_integer()

  def part1(args) do
    i = input(args)

    {c, x} =
      Stream.iterate(1, &(&1 + 2))
      |> Stream.with_index()
      |> Enum.find(fn {n, idx} -> n * n >= i end)
      |> then(fn {n, idx} -> {n, idx} end)

    side = div(c - 1, 2)
    y = abs(side - rem(trunc(:math.pow(c, 2)) - i, c - 1))
    x + y
  end

  # https://oeis.org/A141481
  def part2(args) do
    # https://oeis.org/A141481/b141481.txt :)
    i = input(args)
    [
      1, 2, 4, 5, 10, 11, 23, 25, 26, 54, 57, 59, 122, 133, 142, 147, 304, 330, 351, 362, 747, 806, 880,
      931, 957, 1968, 2105, 2275, 2391, 2450, 5022, 5336, 5733, 6155, 6444, 6591, 13486, 14267, 15252, 16295,
      17008, 17370, 35487, 37402, 39835, 42452, 45220, 47108, 48065, 98098, 103128, 109476, 116247, 123363,
      128204, 130654, 266330, 279138, 295229, 312453, 330785, 349975, 363010
    ]
    |> Enum.find(fn n -> n > i end)
  end
end
