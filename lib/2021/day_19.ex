defmodule AdventOfCode.Y2021.Day19 do
  use Memoize

  defp prepare_input(raw_input) do
    raw_input
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, "\n", trim: true)
      |> tl()
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(fn [x, y, z] ->
        {String.to_integer(x), String.to_integer(y), String.to_integer(z)}
      end)
    end)
  end

  defp resolve_scanner_locations(beacons),
    do: resolve_scanner_locations(beacons, %{0 => {{0, 0, 0}, []}})

  defp resolve_scanner_locations([], acc), do: acc

  defp resolve_scanner_locations([{{scanner1, scanner2}, beacon1, beacon2, rot_idx} | rest], acc)
       when is_map_key(acc, scanner1) do
    {{bx, by, bz}, rot} = Map.get(acc, scanner1)
    new_rot = [rot_idx | rot]

    {x1, y1, z1} = beacon1
    {rx, ry, rz} = rotations(beacon2) |> Enum.at(rot_idx)

    {px, py, pz} =
      Enum.reduce(rot, {x1 - rx, y1 - ry, z1 - rz}, fn idx, acc ->
        rotations(acc) |> Enum.at(idx)
      end)

    acc = Map.put(acc, scanner2, {{bx + px, by + py, bz + pz}, new_rot})
    resolve_scanner_locations(rest, acc)
  end

  defp resolve_scanner_locations([scanner | rest], acc) do
    resolve_scanner_locations(rest ++ [scanner], acc)
  end

  defp matching_beacons(scan_distances) do
    matching_beacons =
      for {scan1, idx1} <- scan_distances, {scan2, idx2} <- scan_distances, idx1 != idx2 do
        prod =
          for {beacon1, distances1} <- scan1,
              {beacon2, distances2} <- scan2 do
            {{beacon1, distances1}, {beacon2, distances2}}
          end

        Enum.find_value(prod, fn {{beacon1, distances1}, {beacon2, distances2}} ->
          rotations =
            distances2
            |> Enum.map(&rotations/1)
            |> Enum.zip()
            |> Enum.map(&Tuple.to_list/1)
            |> Enum.with_index()

          ds = MapSet.new(distances1)

          Enum.find_value(rotations, fn {rotation, rot_idx} ->
            {dd1, dd2} = {MapSet.new(rotation), ds}

            if MapSet.size(MapSet.intersection(dd1, dd2)) >= 11 do
              {{idx1, idx2}, beacon1, beacon2, rot_idx}
            else
              nil
            end
          end)
        end)
      end

    matching_beacons
    |> List.flatten()
    |> Enum.reject(fn a -> a == nil end)
    |> Enum.uniq_by(&elem(&1, 0))
  end

  defmemo rotations({x, y, z}) do
    [
      {x, y, z},
      {-y, x, z},
      {-x, -y, z},
      {y, -x, z},
      {x, -z, y},
      {z, x, y},
      {-x, z, y},
      {-z, -x, y},
      {x, z, -y},
      {-z, x, -y},
      {-z, -x, -y},
      {-x, -z, -y},
      {z, -x, -y},
      {x, -y, -z},
      {y, x, -z},
      {-y, z, -x},
      {-x, y, -z},
      {-y, -x, -z},
      {-z, y, x},
      {-y, -z, x},
      {z, -y, x},
      {y, z, x},
      {z, y, -x},
      {-z, -y, -x},
      {y, -z, -x}
    ]
  end

  defp distances(scan) do
    distances =
      for a = {x1, y1, z1} <- scan,
          b = {x2, y2, z2} <- scan,
          a != b do
        {a, {x1 - x2, y1 - y2, z1 - z2}}
      end

    distances
    |> Enum.sort()
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
  end

  def part1(args) do
    scans = args |> prepare_input()

    scan_distances = scans |> Enum.map(&distances/1) |> Enum.with_index()
    matching_beacons = matching_beacons(scan_distances)
    scanner_locations = matching_beacons |> resolve_scanner_locations()

    Enum.with_index(scans)
    |> Enum.flat_map(fn {scan, idx} ->
      {{px, py, pz}, rots} = Map.get(scanner_locations, idx)

      Enum.map(scan, fn coord ->
        {x, y, z} =
          Enum.reduce(rots, coord, fn idx, acc ->
            rotations(acc) |> Enum.at(idx)
          end)

        {x + px, y + py, z + pz}
      end)
    end)
    |> Enum.uniq()
    |> length()
  end

  def part2(args) do
    scans = args |> prepare_input()
    scan_distances = scans |> Enum.map(&distances/1) |> Enum.with_index()
    matching_beacons = matching_beacons(scan_distances)
    scanner_locations = matching_beacons |> resolve_scanner_locations()

    coords = Enum.map(scanner_locations, fn {_, {coords, _}} -> coords end)

    mans =
      for l1 <- coords, l2 <- coords, l1 != l2 do
        manhattan(l1, l2)
      end

    Enum.max(mans)
  end

  def manhattan({x1, y1, z1}, {x2, y2, z2}), do: abs(x1 - x2) + abs(y1 - y2) + abs(z1 - z2)
end
