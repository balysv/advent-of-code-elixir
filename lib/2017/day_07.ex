defmodule AdventOfCode.Y2017.Day07 do
  # suvtxzq (242) -> tdoxrnb, oanxgk
  # smjsfux (7)

  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      case String.split(s, ["(", ")", ") ->"], trim: true) do
        [a, b] ->
          {String.trim(a), {String.to_integer(b), []}}

        [a, b, c] ->
          {String.trim(a), {String.to_integer(b), String.split(c, [" ", ", "], trim: true)}}
      end
    end)
    |> Map.new()
  end

  defp root_program(input) do
    all_leaves =
      input
      |> Enum.flat_map(fn {_, {_, leaves}} -> leaves end)
      |> MapSet.new()

    input
    |> Enum.find(nil, fn
      {_, {_, []}} ->
        false

      {pgrm, {_, _}} ->
        not MapSet.member?(all_leaves, pgrm)
    end)
    |> elem(0)
  end

  def part1(args) do
    args
    |> prepare_input()
    |> root_program()
  end

  def part2(args) do
    input = prepare_input(args)
    root = root_program(input)
  end
end
