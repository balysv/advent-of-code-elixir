defmodule AdventOfCode.Y2015.Day15 do
  # Sprinkles: capacity 2, durability 0, flavor -2, texture 0, calories 3

  defp prepare_input(raw) do
    raw
    |> String.split(
      ["\n", ": capacity ", ", durability ", " flavor ", ", texture ", ", calories "],
      trim: true
    )
    |> Enum.chunk_every(6)
    |> Enum.map(&List.to_tuple/1)
  end

  def part1(_args) do
    inputs()
    |> Enum.map(&compute/1)
    |> Enum.max()
  end

  def part2(_args) do
    inputs()
    |> Enum.filter(fn {a, b, c, d} -> 3 * a + 3 * b + 8 * c + 8 * d == 500 end)
    |> Enum.map(&compute/1)
    |> Enum.max()
  end

  defp inputs() do
    for a <- 1..97,
        b <- 1..(98 - a),
        a + b < 99,
        c <- 1..(99 - a - b),
        a + b + c < 100,
        d <- 1..(100 - a - b - c),
        a + b + c + d == 100,
        do: {a, b, c, d}
  end

  # {"Sprinkles", "2", "0,", "-2", "0", "3"},
  # {"Butterscotch", "0", "5,", "-3", "0", "3"},
  # {"Chocolate", "0", "0,", "5", "-1", "8"},
  # {"Candy", "0", "-1,", "0", "5", "8"}
  defp compute({a, b, c, d}) do
    max(2 * a + 0 * b + 0 * c + 0 * d, 0) *
      max(0 * a + 5 * b + 0 * c + -1 * d, 0) *
      max(-2 * a + -3 * b + 5 * c + 0 * d, 0) *
      max(0 * a + 0 * b + -1 * c + 5 * d, 0)
  end
end
