defmodule AdventOfCode.Y2017.Day05 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Map.new(fn {val, idx} -> {idx, String.to_integer(val)} end)
  end

  def part1(args) do
    instrs = prepare_input(args)

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while({0, instrs}, fn
      _, {idx, instrs} when is_map_key(instrs, idx) ->
        {step, instrs} = Map.get_and_update!(instrs, idx, fn v -> {v, v + 1} end)
        {:cont, {idx + step, instrs}}

      pos, _ ->
        {:halt, pos}
    end)
  end

  def part2(args) do
    instrs = prepare_input(args)

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while({0, instrs}, fn
      _, {idx, instrs} when is_map_key(instrs, idx) ->
        {step, instrs} =
          Map.get_and_update!(instrs, idx, fn
            v when v >= 3 -> {v, v - 1}
            v -> {v, v + 1}
          end)

        {:cont, {idx + step, instrs}}

      pos, _ ->
        {:halt, pos}
    end)
  end
end
