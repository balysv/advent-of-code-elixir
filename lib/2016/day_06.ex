defmodule AdventOfCode.Y2016.Day06 do
  def part1(args), do: args |> String.split("\n", trim: true) |> solve(:desc)

  def part2(args), do: args |> String.split("\n", trim: true) |> solve(:asc)

  defp solve(lines, order) do
    lines
    |> Enum.flat_map(fn line -> line |> String.graphemes() |> Enum.with_index() end)
    |> Enum.group_by(&elem(&1, 1))
    |> Enum.map(fn {_, col} ->
      Enum.map(col, &elem(&1, 0))
      |> Enum.frequencies()
      |> Enum.sort_by(&elem(&1, 1), order)
      |> hd
      |> elem(0)
    end)
    |> Enum.join()
  end
end
