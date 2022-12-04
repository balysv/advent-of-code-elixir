defmodule AdventOfCode.Y2021.Day08 do
  def prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
  end

  def part1(args) do
    prepare_input(args)
    |> Enum.map(fn a -> Enum.at(String.split(a, " | "), 1) end)
    |> Enum.map(fn a ->
      String.split(a, " ") |> Enum.map(fn b -> length(String.graphemes(b)) end)
    end)
    |> List.flatten()
    |> Enum.count(fn c -> c in [2, 3, 4, 7] end)
  end

  def part2(args) do
    full_lines =
      prepare_input(args)
      |> Enum.map(fn a ->
        String.replace(a, " | ", " ")
        |> String.split(" ")
        |> Enum.map(&String.graphemes/1)
        |> Enum.map(&MapSet.new/1)
      end)

    answer_lines = full_lines |> Enum.map(&Enum.slice(&1, -4, 4))

    #  0000
    # 1    2
    # 1    2
    #  3333
    # 4    5
    # 4    5
    #  6666
    digit_positions = %{
      0 => [0, 1, 2, 4, 5, 6],
      1 => [2, 5],
      2 => [0, 2, 3, 4, 6],
      3 => [0, 2, 3, 5, 6],
      4 => [1, 2, 3, 5],
      5 => [0, 1, 3, 5, 6],
      6 => [0, 1, 3, 4, 5, 6],
      7 => [0, 2, 5],
      8 => [0, 1, 2, 3, 4, 5, 6, 7],
      9 => [0, 1, 2, 3, 5, 6]
    }

    scrambled = List.duplicate(MapSet.new(["a", "b", "c", "d", "e", "f", "g"]), 7)

    letters_to_digits =
      full_lines
      |> Enum.map(fn line -> recur(line, scrambled) end)
      |> Enum.map(fn decoded_digits ->
        digit_positions
        |> Enum.map(fn
          {digit, positions} ->
            {decoded_digits
             |> Stream.with_index()
             |> Stream.filter(fn {_, idx} -> idx in positions end)
             |> Stream.map(fn {v, _} -> v end)
             |> MapSet.new(), digit}
        end)
        |> Enum.into(%{})
      end)

    Enum.zip_with(answer_lines, letters_to_digits, fn line, solution ->
      line
      |> Enum.map(&Map.get(solution, &1))
      |> Integer.undigits()
    end)
    |> Enum.sum()
  end

  defp recur([], solved_map), do: solved_map |> Enum.map(&Enum.at(&1, 0))

  defp recur([digits | rest], solved_map) do
    solved_map =
      case MapSet.size(digits) do
        # 1
        2 -> process_concrete_digits(solved_map, digits, [2, 5])
        # 7
        3 -> process_concrete_digits(solved_map, digits, [0, 2, 5])
        # 4
        4 -> process_concrete_digits(solved_map, digits, [1, 2, 3, 5])
        # 2, 3, 5
        5 -> process_ambiguous_digits(solved_map, digits, [0, 3, 6])
        # 0, 6, 9
        6 -> process_ambiguous_digits(solved_map, digits, [0, 1, 5, 6])
        # 8
        7 -> solved_map
      end
      |> deduplicate_digits

    recur(rest, solved_map)
  end

  defp process_concrete_digits(solved_map, digits, positions) do
    Enum.with_index(solved_map)
    |> Enum.map(fn {v, idx} ->
      if idx in positions,
        do: MapSet.intersection(digits, v),
        else: MapSet.difference(v, digits)
    end)
  end

  defp process_ambiguous_digits(solved_map, digits, positions) do
    Enum.with_index(solved_map)
    |> Enum.map(fn {v, idx} ->
      if idx in positions,
        do: MapSet.intersection(digits, v),
        else: v
    end)
  end

  defp deduplicate_digits(solved_map) do
    certain_digits =
      solved_map
      |> Enum.filter(&(MapSet.size(&1) == 1))
      |> Enum.reduce(MapSet.new(), &MapSet.union/2)

    solved_map
    |> Enum.map(fn set ->
      if MapSet.size(set) > 1, do: MapSet.difference(set, certain_digits), else: set
    end)
  end
end
