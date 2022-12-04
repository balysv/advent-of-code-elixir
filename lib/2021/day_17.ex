defmodule AdventOfCode.Y2021.Day17 do
  defp prepare_input("target area: x=" <> input) do
    [x1, x2, y1, y2] =
      input
      |> String.trim()
      |> String.split([", y=", ".."])
      |> Enum.map(&String.to_integer/1)

    {x1, x2, y1, y2}
  end

  def part1(args) do
    args |> prepare_input() |> compute_all_hits() |> Enum.map(&elem(&1, 1)) |> Enum.max()
  end

  def part2(args) do
    args |> prepare_input() |> compute_all_hits() |> Enum.map(&elem(&1, 0)) |> Enum.count()
  end

  defp compute_all_hits(target = {_, tx2, ty1, _}) do
    for ex <- 1..tx2,
        ey <- ty1..(abs(ty1) - 1),
        velocity = {ex, ey},
        {state, max_y} = step({0, 0}, velocity, 0, target),
        state == :hit,
        do: {velocity, max_y}
  end

  defp step({x, y}, _, max_y, {tx1, tx2, ty1, ty2}) when x in tx1..tx2 and y in ty1..ty2,
    do: {:hit, max_y}

  defp step({x, y}, _, _, {_, tx2, ty1, _}) when x > tx2 or y < ty1, do: {:miss, -1}

  defp step({x, y}, {vx, vy}, max_y, target) do
    x = x + vx
    y = y + vy
    v = {vx + drag(vx), vy - 1}
    step({x, y}, v, max(max_y, y), target)
  end

  defp drag(vx) when vx > 0, do: -1
  defp drag(vx) when vx < 0, do: 1
  defp drag(_), do: 0
end
