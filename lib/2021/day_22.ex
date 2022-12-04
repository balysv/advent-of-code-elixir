defmodule AdventOfCode.Y2021.Day22 do
  defp prepare_input(raw) do
    raw
    |> String.split(["\n", " x=", ",y=", ",z="], trim: true)
    |> Enum.chunk_every(4)
    |> Enum.map(fn [instr, xs, ys, zs] ->
      {String.to_atom(instr), {parse_range(xs), parse_range(ys), parse_range(zs)}}
    end)
  end

  defp parse_range(str) do
    [a, b] = String.split(str, "..")
    String.to_integer(a)..String.to_integer(b)
  end

  def part1(args), do: args |> prepare_input() |> Enum.take(20) |> recur([]) |> count()

  def part2(args), do: args |> prepare_input() |> recur([]) |> count()

  defp recur([], acc), do: acc

  defp recur([{op, cube} | steps], acc) do
    acc =
      Enum.flat_map(acc, fn existing_cube ->
        if overlaps?(cube, existing_cube),
          do: substract(existing_cube, cube),
          else: [existing_cube]
      end)

    acc = acc |> append_if(op == :on, cube)
    recur(steps, acc)
  end

  defp overlaps?({x1..xm1, y1..ym1, z1..zm1}, {x2..xm2, y2..ym2, z2..zm2}) do
    xm1 >= x2 and x1 <= xm2 and (ym1 >= y2 and y1 <= ym2) and (zm1 >= z2 and z1 <= zm2)
  end

  defp substract(c1, c2) when c1 == c2, do: []

  defp substract(c1 = {x..xm, y..ym, z..zm}, c2) do
    true = overlaps?(c1, c2)
    overlap = {cx..cmx, cy..cmy, cz..cmz} = overlapping_cube(c1, c2)

    xs = ranges([x, cx, cmx, xm])
    ys = ranges([y, cy, cmy, ym])
    zs = ranges([z, cz, cmz, zm])

    divided_cubes =
      for [x1, x2] <- xs, [y1, y2] <- ys, [z1, z2] <- zs, do: {x1..x2, y1..y2, z1..z2}

    divided_cubes -- [overlap]
  end

  defp overlapping_cube({x1..xm1, y1..ym1, z1..zm1}, {x2..xm2, y2..ym2, z2..zm2}) do
    {max(x1, x2)..min(xm1, xm2), max(y1, y2)..min(ym1, ym2), max(z1, z2)..min(zm1, zm2)}
  end

  defp ranges([x1, x2, x3, x4]) do
    [[x2, x3]]
    |> append_if(x1 != x2, [x1, x2 - 1])
    |> append_if(x3 != x4, [x3 + 1, x4])
  end

  defp count(cubes) do
    Enum.reduce(cubes, 0, fn {x1..x2, y1..y2, z1..z2}, acc ->
      acc + (1 + x2 - x1) * (1 + y2 - y1) * (1 + z2 - z1)
    end)
  end

  defp append_if(list, condition, value) do
    if condition, do: [value | list], else: list
  end
end
