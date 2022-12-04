defmodule AdventOfCode.Y2015.Day05 do
  defp prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
  end

  def part1(args) do
    args |> prepare_input() |> Enum.filter(&nice_p1?/1) |> Enum.count()
  end

  defp nice_p1?(string) do
    !String.contains?(string, ["ab", "cd", "pq", "xy"]) and
      String.match?(string, ~r/(.)\1/) and
      String.split(string, ["a", "e", "i", "o", "u"]) |> length() > 3
  end

  def part2(args) do
    args |> prepare_input() |> Enum.filter(&nice_p2?/1) |> Enum.count()
  end

  defp nice_p2?(string) do
    String.match?(string, ~r/(.).\1/) and
      String.match?(string, ~r/(.{2}).*\1/)
  end
end
