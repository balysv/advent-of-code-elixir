defmodule AdventOfCode.Y2022.Day20 do
  defp prepare_input(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index(1)
  end

  defp new_position(pos, offset, size) do
    new_pos = rem(pos + offset, size - 1)
    new_pos = if new_pos < 0, do: size + new_pos - 1, else: new_pos
    new_pos = if new_pos == 0 and offset < 0, do: size, else: new_pos
    new_pos
  end

  defp mix(list) do
    size = length(list)

    1..size
    |> Enum.reduce(list, fn idx, list ->
      pos = Enum.find_index(list, &match?({_, ^idx}, &1))
      {{offset, ^idx}, list} = List.pop_at(list, pos)
      new_pos = new_position(pos, offset, size)
      List.insert_at(list, new_pos, {offset, idx})
    end)
  end

  defp result(list, pos_of_0) do
    Enum.at(list, pos_of_0 + 1000) +
      Enum.at(list, pos_of_0 + 2000) +
      Enum.at(list, pos_of_0 + 3000)
  end

  def part1(args) do
    input = prepare_input(args)

    mixed_list = input |> mix() |> Enum.map(&elem(&1, 0))
    pos_of_0 = Enum.find_index(mixed_list, &match?(0, &1))
    result(Stream.cycle(mixed_list), pos_of_0)
  end

  def part2(args) do
    input = args |> prepare_input() |> Enum.map(fn {v, idx} -> {v * 811_589_153, idx} end)

    mixed_list =
      1..10
      |> Enum.reduce(input, fn _, list -> mix(list) end)
      |> Enum.map(&elem(&1, 0))

    pos_of_0 = Enum.find_index(mixed_list, &match?(0, &1))
    result(Stream.cycle(mixed_list), pos_of_0)
  end
end
