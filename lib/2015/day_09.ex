defmodule AdventOfCode.Y2015.Day09 do
  defp prepare_input(raw) do
    distances =
      raw
      |> String.split([" to ", " = ", "\n"], trim: true)
      |> Enum.chunk_every(3)
      |> Enum.flat_map(fn [src, dest, dist] ->
        dist = String.to_integer(dist)
        [{{src, dest}, dist}, {{dest, src}, dist}]
      end)
      |> Enum.into(%{})

    cities =
      Map.keys(distances)
      |> Enum.flat_map(&Tuple.to_list/1)
      |> Enum.uniq()

    {cities, distances}
  end

  def part1(args), do: args |> prepare_input |> all_distances() |> Enum.min()
  def part2(args), do: args |> prepare_input |> all_distances() |> Enum.max()

  defp all_distances({cities, distances}) do
    cities
    |> Enum.flat_map(fn city ->
      paths(cities -- [city], [city]) |> Enum.chunk_every(length(cities))
    end)
    |> Enum.map(fn path ->
      Enum.chunk_every(path, 2, 1, :discard)
      |> Enum.map(fn [src, dst] -> Map.get(distances, {src, dst}, 999_999) end)
      |> Enum.sum()
    end)
  end

  defp paths([], acc), do: acc

  defp paths(others, acc) do
    others |> Enum.flat_map(fn other -> paths(others -- [other], [other | acc]) end)
  end
end
