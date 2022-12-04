defmodule AdventOfCode.Y2016.Day17 do
  def part1(args) do
    passcode = args |> String.trim()

    dfs({"", 0, 0}, passcode, "", String.duplicate("U", 100), &Kernel.</2)
    |> List.flatten()
    |> Enum.min_by(&String.length/1)
  end

  def part2(args) do
    passcode = args |> String.trim()

    dfs({"", 0, 0}, passcode, "", "", &Kernel.>/2)
    |> List.flatten()
    |> Enum.max_by(&String.length/1)
    |> String.length()
  end

  defp dfs({_, 3, 3}, _, path, min_path, op) do
    if op.(String.length(path), String.length(min_path)), do: path, else: min_path
  end

  defp dfs(c, passcode, path, min_path, op) do
    if op.(String.length(min_path), String.length(path)) do
      min_path
    else
      moves = available_moves(c, passcode, path)

      r =
        for move = {d, _, _} <- moves do
          dfs(move, passcode, path <> d, min_path, op)
        end

      if length(r) == 0, do: min_path, else: r
    end
  end

  defp available_moves({_, x, y}, passcode, path) do
    :crypto.hash(:md5, passcode <> path)
    |> Base.encode16()
    |> String.slice(0..3)
    |> String.graphemes()
    |> Enum.map(fn
      c when c in ["B", "C", "D", "E", "F"] -> true
      _ -> false
    end)
    |> Enum.zip([{"U", x, y - 1}, {"D", x, y + 1}, {"L", x - 1, y}, {"R", x + 1, y}])
    |> Enum.filter(fn {open, {_, x, y}} -> open and x in 0..3 and y in 0..3 end)
    |> Enum.map(&elem(&1, 1))
  end
end
