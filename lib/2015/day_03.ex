defmodule AdventOfCode.Y2015.Day03 do
  defmodule Solver do
    def solve_p1(input), do: solve(input, {0, 0}, MapSet.new([{0, 0}]))
    def solve_p2(input), do: solve(input, [{0, 0}, {0, 0}], MapSet.new([{0, 0}]))

    defp solve("", _, seen), do: seen

    defp solve(<<f::bytes-size(1)>> <> <<s::bytes-size(1)>> <> rest, [fc, sc], seen) do
      fc = move(f, fc)
      sc = move(s, sc)
      seen = seen |> MapSet.put(fc) |> MapSet.put(sc)
      solve(rest, [fc, sc], seen)
    end

    defp solve(<<f::bytes-size(1)>> <> rest, fc, seen) do
      fc = move(f, fc)
      seen = MapSet.put(seen, fc)
      solve(rest, fc, seen)
    end

    defp move("^", {x, y}), do: {x, y - 1}
    defp move("v", {x, y}), do: {x, y + 1}
    defp move(">", {x, y}), do: {x + 1, y}
    defp move("<", {x, y}), do: {x - 1, y}
  end

  def part1(args) do
    args |> String.trim() |> Solver.solve_p1() |> MapSet.size()
  end

  def part2(args) do
    args |> String.trim() |> Solver.solve_p2() |> MapSet.size()
  end
end
