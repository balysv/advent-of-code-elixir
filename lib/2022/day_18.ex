defmodule AdventOfCode.Y2022.Day18 do
  def prepare_input(args) do
    args
    |> String.split([",", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3)
    |> Enum.map(&List.to_tuple/1)
    |> Enum.sort()
  end

  defp group_by_coord(coords) do
    xy_z = coords |> Enum.group_by(fn {x, y, _z} -> {x, y} end, &elem(&1, 2)) |> to_ranges()
    xz_y = coords |> Enum.group_by(fn {x, _y, z} -> {x, z} end, &elem(&1, 1)) |> to_ranges()
    yz_x = coords |> Enum.group_by(fn {_x, y, z} -> {y, z} end, &elem(&1, 0)) |> to_ranges()
    [xy_z, xz_y, yz_x]
  end

  defp to_ranges(coords) do
    coords
    |> Enum.map(fn {coord, points} ->
      ranges =
        points
        |> Enum.sort(:asc)
        |> Enum.reduce([], fn
          point, [st..en | rest] when en + 1 == point ->
            [st..point | rest]

          point, acc ->
            [point..point | acc]
        end)
        |> Enum.sort_by(fn st.._ -> st end)

      {coord, ranges}
    end)
  end

  defp count_faces(ranges) do
    ranges
    |> Enum.concat()
    |> Enum.map(&elem(&1, 1))
    |> List.flatten()
    |> Enum.count()
    |> Kernel.*(2)
  end

  defp adjescant({x, y, z}) do
    [
      {x + 1, y, z},
      {x - 1, y, z},
      {x, y + 1, z},
      {x, y - 1, z},
      {x, y, z + 1},
      {x, y, z - 1}
    ]
  end

  defp surrounded?(hole, coords, holes, seen, cache) do
    hole
    |> adjescant()
    |> Enum.reject(&MapSet.member?(seen, &1))
    |> Enum.all?(fn coord ->
      cond do
        coord in coords ->
          true

        coord in holes and length(:ets.lookup(cache, coord)) > 0 ->
          [{_, v}] = :ets.lookup(cache, coord)
          v

        coord in holes ->
          v = surrounded?(coord, coords, holes, MapSet.put(seen, coord), cache)
          :ets.insert(cache, {coord, v})
          v

        true ->
          false
      end
    end)
  end

  def part1(args) do
    args
    |> prepare_input()
    |> group_by_coord()
    |> count_faces()
  end

  def part2(args) do
    coords = prepare_input(args)
    [xy_z, xz_y, yz_x] = group_by_coord(coords)

    all_holes =
      [
        inverse_ranges(xy_z, fn x, y, z -> {x, y, z} end),
        inverse_ranges(xz_y, fn x, z, y -> {x, y, z} end),
        inverse_ranges(yz_x, fn y, z, x -> {x, y, z} end)
      ]
      |> Enum.concat()
      |> Enum.uniq()

    cache = :ets.new(:store, [:set, :public])

    [h_xy_z, h_xz_y, h_yz_x] =
      all_holes
      |> Enum.filter(&surrounded?(&1, coords, all_holes, MapSet.new([&1]), cache))
      |> group_by_coord()

    count_faces([xy_z, xz_y, yz_x]) - count_faces([h_xy_z, h_xz_y, h_yz_x])
  end

  defp inverse_ranges(input, map_fn) do
    Enum.flat_map(input, fn {{a, b}, cs} ->
      cs
      |> Enum.reduce({nil, []}, fn
        _..en, {nil, acc} -> {en, acc}
        st..en, {last, acc} -> {en, [(last + 1)..(st - 1) | acc]}
      end)
      |> elem(1)
      |> Enum.flat_map(&Enum.map(&1, fn c -> map_fn.(a, b, c) end))
    end)
  end
end
