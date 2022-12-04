defmodule AdventOfCode.Y2022.Day02 do
  defp prepare_input(raw) do
    raw
    |> String.split(["\n", " "], trim: true)
    |> Enum.chunk_every(2)
  end

  defp score("X"), do: 1
  defp score("Y"), do: 2
  defp score("Z"), do: 3
  defp score("A"), do: 1
  defp score("B"), do: 2
  defp score("C"), do: 3

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.map(fn
      ["A", "Y"] -> score("Y") + 6
      ["B", "Z"] -> score("Z") + 6
      ["C", "X"] -> score("X") + 6
      ["A", "X"] -> score("X") + 3
      ["B", "Y"] -> score("Y") + 3
      ["C", "Z"] -> score("Z") + 3
      [_a, b] -> score(b)
    end)
    |> Enum.sum()
  end

  @moves ["A", "B", "C"]

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.map(fn
      [a, "X"] ->
        index = Enum.find_index(@moves, &(&1 == a)) - 1
        score(Enum.at(@moves, index))

      [a, "Y"] ->
        score(a) + 3

      [a, "Z"] ->
        moves = Enum.reverse(@moves)
        index = Enum.find_index(moves, &(&1 == a)) - 1
        score(Enum.at(moves, index)) + 6
    end)
    |> Enum.sum()
  end
end
