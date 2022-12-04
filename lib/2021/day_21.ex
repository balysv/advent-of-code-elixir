defmodule AdventOfCode.Y2021.Day21 do
  use Memoize

  defp prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.slice(&1, -1..byte_size(&1)))
    |> Enum.map(&String.to_integer/1)
  end


  def part1(args) do
    [pos1, pos2] = args |> prepare_input()

    Enum.reduce_while(deterministic_dice(), {{pos1, 0}, {pos2, 0}}, fn
      {_, turn}, {{_, s1}, {_, s2}} when s1 > 999 or s2 > 999 ->
        {:halt, {turn * 3, min(s1, s2)}}

      {roll_value, turn}, {{p1, s1}, {p2, s2}} ->
        p1? = rem(turn, 2) == 0

        if p1? do
          p1 = roll_position(p1, roll_value)
          {:cont, {{p1, s1 + p1}, {p2, s2}}}
        else
          p2 = roll_position(p2, roll_value)
          {:cont, {{p1, s1}, {p2, s2 + p2}}}
        end
    end)
    |> Tuple.product()
  end

  defp deterministic_dice do
    die = Stream.cycle(1..100)
    Stream.zip([
      die |> Stream.take_every(3),
      die |> Stream.drop(1) |> Stream.take_every(3),
      die |> Stream.drop(2) |> Stream.take_every(3)
    ])
    |> Stream.map(&Tuple.sum/1)
    |> Stream.with_index()
  end

  def part2(args) do
    [pos1, pos2] = args |> prepare_input()
    {w1, w2} = turn({0, pos1, 0}, {1, pos2, 0})
    max(w1, w2)
  end

  defmemo turn({_, _, _}, {id, _, s}) when s >= 21 do
    if id == 0, do: {1, 0}, else: {0, 1}
  end

  defmemo turn({id, p, s}, player2) do
    wins =
      for roll_value <- driac_dice() do
        p = roll_position(p, roll_value)
        turn(player2, {id, p, s + p})
      end
    Enum.reduce(wins, {0, 0}, fn {w1, w2}, {e1, e2} -> {e1 + w1, e2 + w2} end)
  end

  defmemo driac_dice do
    for i <- 1..3, j <- 1..3, k <- 1..3, do: i + j + k
  end

  defp roll_position(p, roll_value), do: rem(p + roll_value - 1, 10) + 1
end
