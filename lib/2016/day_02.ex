defmodule AdventOfCode.Y2016.Day02 do
  defmodule P1 do
    def recur([], digit), do: digit

    def recur([f | rest], digit), do: recur(rest, traverse(digit, f))

    defp traverse(1, "R"), do: 2
    defp traverse(1, "D"), do: 4
    defp traverse(1, _), do: 1

    defp traverse(2, "R"), do: 3
    defp traverse(2, "D"), do: 5
    defp traverse(2, "L"), do: 1
    defp traverse(2, _), do: 2

    defp traverse(3, "D"), do: 6
    defp traverse(3, "L"), do: 2
    defp traverse(3, _), do: 3

    defp traverse(4, "R"), do: 5
    defp traverse(4, "D"), do: 7
    defp traverse(4, _), do: 4

    defp traverse(5, "R"), do: 6
    defp traverse(5, "D"), do: 8
    defp traverse(5, "L"), do: 4
    defp traverse(5, "U"), do: 2

    defp traverse(6, "D"), do: 9
    defp traverse(6, "L"), do: 5
    defp traverse(6, "U"), do: 3
    defp traverse(6, _), do: 6

    defp traverse(7, "R"), do: 8
    defp traverse(7, "U"), do: 4
    defp traverse(7, _), do: 7

    defp traverse(8, "R"), do: 9
    defp traverse(8, "L"), do: 7
    defp traverse(8, "U"), do: 5
    defp traverse(8, _), do: 5

    defp traverse(9, "L"), do: 8
    defp traverse(9, "U"), do: 6
    defp traverse(9, _), do: 9
  end

  defmodule P2 do
    def recur([], digit), do: digit

    def recur([f | rest], digit), do: recur(rest, traverse(digit, f))

    defp traverse(1, "D"), do: 3
    defp traverse(1, _), do: 1

    defp traverse(2, "R"), do: 3
    defp traverse(2, "D"), do: 6
    defp traverse(2, _), do: 2

    defp traverse(3, "D"), do: 7
    defp traverse(3, "L"), do: 2
    defp traverse(3, "R"), do: 4
    defp traverse(3, "U"), do: 1

    defp traverse(4, "L"), do: 3
    defp traverse(4, "D"), do: 8
    defp traverse(4, _), do: 4

    defp traverse(5, "R"), do: 6
    defp traverse(5, _), do: 5

    defp traverse(6, "D"), do: "A"
    defp traverse(6, "L"), do: 5
    defp traverse(6, "U"), do: 2
    defp traverse(6, "R"), do: 7

    defp traverse(7, "R"), do: 8
    defp traverse(7, "U"), do: 3
    defp traverse(7, "L"), do: 6
    defp traverse(7, "D"), do: "B"

    defp traverse(8, "R"), do: 9
    defp traverse(8, "L"), do: 7
    defp traverse(8, "U"), do: 4
    defp traverse(8, "D"), do: "C"

    defp traverse(9, "L"), do: 8
    defp traverse(9, _), do: 9

    defp traverse("A", "R"), do: "B"
    defp traverse("A", "U"), do: 6
    defp traverse("A", _), do: "A"

    defp traverse("B", "R"), do: "C"
    defp traverse("B", "L"), do: "A"
    defp traverse("B", "U"), do: 7
    defp traverse("B", "D"), do: "D"

    defp traverse("C", "L"), do: "B"
    defp traverse("C", "U"), do: 8
    defp traverse("C", _), do: "C"

    defp traverse("D", "U"), do: "B"
    defp traverse("D", _), do: "D"
  end

  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  def part1(args), do: args |> prepare_input() |> Enum.map(&P1.recur(&1, 5)) |> Enum.join()

  def part2(args), do: args |> prepare_input() |> Enum.map(&P2.recur(&1, 5)) |> Enum.join()
end
