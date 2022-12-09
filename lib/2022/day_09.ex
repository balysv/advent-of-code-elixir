defmodule AdventOfCode.Y2022.Day09 do
  defp prepare_input(raw) do
    raw
    |> String.split(["\n", " "], trim: true)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [d, c] -> {d, String.to_integer(c)} end)
    |> Enum.flat_map(&to_deltas/1)
  end

  defp repeat(input, times), do: for(_ <- 0..(times - 1), do: input)
  defp to_deltas({"U", c}), do: repeat({0, 1}, c)
  defp to_deltas({"D", c}), do: repeat({0, -1}, c)
  defp to_deltas({"L", c}), do: repeat({-1, 0}, c)
  defp to_deltas({"R", c}), do: repeat({1, 0}, c)

  defp head_position({hx, hy}, {dx, dy}), do: {hx + dx, hy + dy}

  defp tail_position({hx, hy} = hd, {tx, ty} = tl) do
    if not adjescant?(hd, tl),
      do: {tx + tail_delta(hx, tx), ty + tail_delta(hy, ty)},
      else: tl
  end

  defp adjescant?({hx, hy}, {tx, ty}), do: abs(hx - tx) <= 1 and abs(hy - ty) <= 1
  defp tail_delta(hc, hc), do: 0
  defp tail_delta(hc, tc) when hc > tc, do: 1
  defp tail_delta(hc, tc) when hc < tc, do: -1

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.reduce({{0, 0}, {0, 0}, MapSet.new()}, fn
      delta, {hd_pos, tl_pos, seen} ->
        hd_pos = head_position(hd_pos, delta)
        tl_pos = tail_position(hd_pos, tl_pos)
        {hd_pos, tl_pos, MapSet.put(seen, tl_pos)}
    end)
    |> elem(2)
    |> MapSet.size()
  end

  def part2(args) do
    rope = repeat({0, 0}, 10)

    args
    |> prepare_input()
    |> Enum.reduce({rope, MapSet.new()}, fn
      delta, {rope, seen} ->
        rope =
          Enum.reduce(rope, [], fn
            hd, [] -> [head_position(hd, delta)]
            tl, [hd | _] = acc -> [tail_position(hd, tl) | acc]
          end)

        {Enum.reverse(rope), MapSet.put(seen, hd(rope))}
    end)
    |> elem(1)
    |> MapSet.size()
  end
end
