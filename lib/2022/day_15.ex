defmodule AdventOfCode.Y2022.Day15 do
  defp prepare_input(args) do
    args
    |> String.split(["Sensor at x=", ", y=", ": closest beacon is at x=", "\n"], trim: true)
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(2)
    |> Stream.chunk_every(2)
    |> Stream.map(fn [sensor, beacon] -> {sensor, manhattan(sensor, beacon)} end)
    |> Enum.reduce(%{}, fn {[sx, sy], dist}, covered ->
      {min_x, max_x} = {sx - dist, sx + dist}

      0..dist
      |> Stream.map(fn idx ->
        %{
          (sy + idx) => [(min_x + idx)..(max_x - idx)],
          (sy - idx) => [(min_x + idx)..(max_x - idx)]
        }
      end)
      |> Enum.reduce(covered, fn range, acc ->
        Map.merge(acc, range, fn _key, v1, [v2] -> merge_ranges([v2 | v1]) end)
      end)
    end)
  end

  defp manhattan([x1, y1], [x2, y2]), do: abs(x1 - x2) + abs(y1 - y2)

  defp merge_ranges(covered) do
    covered
    |> Enum.sort_by(fn s1.._ -> s1 end, :desc)
    |> Enum.reduce([], fn
      range, [] ->
        [range]

      s1..e1 = r1, [s2..e2 = r2 | rest] = acc ->
        if Range.disjoint?(r1, r2) and e1 + 1 != s2 do
          [r1 | acc]
        else
          s = if s1 < s2, do: s1, else: s2
          e = if e1 > e2, do: e1, else: e2
          [s..e | rest]
        end
    end)
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Stream.filter(fn {y, _} -> y == 2_000_000 end)
    |> Stream.flat_map(&elem(&1, 1))
    |> Stream.map(fn range -> Range.size(range) - 1 end)
    |> Enum.sum()
  end

  def part2(args) do
    # slow; probably best to keep track of possible beacon positions instead
    args
    |> prepare_input()
    |> Stream.map(fn {y, ranges} -> {y, merge_ranges(ranges)} end)
    |> Enum.find(fn {y, ranges} ->
      y >= 0 and y <= 4_000_000 and length(ranges) > 1 and
        Enum.all?(ranges, fn s..e -> s > 0 or e < 4_000_000 end)
    end)
    |> then(fn {y, [_, s2.._]} -> {s2 - 1, y} end)
    |> then(fn {x, y} -> x * 4_000_000 + y end)
  end
end
