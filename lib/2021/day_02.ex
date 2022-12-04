defmodule AdventOfCode.Y2021.Day02 do

  defp prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [command, arg] = String.split(line)
      {command, String.to_integer(arg)}
    end)
  end

  def part1(raw_input) do
    {h, d} = prepare_input(raw_input)
      |> Enum.reduce({0, 0}, fn
        {"forward", v}, {h, d} -> {h + v, d}
        {"down", v}, {h, d} ->{h, d + v}
        {"up", v}, {h, d} -> {h , d - v}
      end)
    h * d
  end

  def part2(raw_input) do
    {h, d, _} = prepare_input(raw_input)
      |> Enum.reduce({0, 0, 0}, fn
        {"forward", v}, {h, d, a} -> {h + v, d + a * v, a}
        {"down", v}, {h, d, a} ->{h, d, a + v}
        {"up", v}, {h, d, a} -> {h , d, a - v}
      end)
  h * d
  end
end
