defmodule AdventOfCode.Y2022.Day05 do
  defp prepare_input(raw) do
    [crates, moves] = String.split(raw, "\n\n", trim: true)

    crates =
      crates
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.codepoints()
        |> Enum.chunk_every(4)
        |> Enum.map(&Enum.at(&1, 1))
      end)
      |> Enum.reverse()
      |> Enum.reduce(%{}, fn crates, acc ->
        crates
        |> Enum.with_index()
        |> Enum.reduce(acc, fn
          {" ", _}, map -> map
          {v, idx}, map -> Map.update(map, idx + 1, [], fn ex -> [v | ex] end)
        end)
      end)

    moves =
      moves
      |> String.split(["\n", "move ", " from ", " to "], trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(3)

    {crates, moves}
  end

  def part1(args) do
    {crates, moves} = prepare_input(args)

    Enum.reduce(moves, crates, fn [times, src, tgrt], crates ->
      {removed, remaining} = crates |> Map.get(src) |> Enum.split(times)

      crates
      |> Map.update!(tgrt, fn ex ->
        Enum.reduce(removed, ex, fn n, e -> [n | e] end)
      end)
      |> Map.replace(src, remaining)
    end)
    |> Enum.map(fn {_idx, [hd | _rem]} -> hd end)
    |> Enum.join()
  end

  def part2(args) do
    {crates, moves} = prepare_input(args)

    Enum.reduce(moves, crates, fn [times, src, tgrt], crates ->
      {removed, remaining} = crates |> Map.get(src) |> Enum.split(times)

      crates
      |> Map.update!(tgrt, &Enum.concat(removed, &1))
      |> Map.replace(src, remaining)
    end)
    |> Enum.map(fn {_idx, [hd | _rem]} -> hd end)
    |> Enum.join()
  end
end
