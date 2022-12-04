defmodule AdventOfCode.Y2016.Day07 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      addrs = String.split(line, ~r/\[[a-z]*\]/)
      seqs = Regex.scan(~r/\[([a-z]+)\]/, line, capture: :all_but_first) |> List.flatten()
      {addrs, seqs}
    end)
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.filter(fn {addrs, seq} ->
      Enum.any?(addrs, &has_abba?/1) and !Enum.any?(seq, &has_abba?/1)
    end)
    |> Enum.count()
  end

  defp has_abba?(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.any?(fn [a, b, c, d] ->
      a == d and b == c and a != b
    end)
  end

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.filter(fn {addrs, seq} ->
      all_abas(addrs)
      |> Enum.any?(fn aba -> Enum.any?(seq, &has_bab?(&1, aba)) end)
    end)
    |> Enum.count()
  end

  defp all_abas(addrs), do: addrs |> Enum.flat_map(&find_aba/1) |> Enum.reject(&Enum.empty?/1)

  defp find_aba(addr) do
    addr
    |> String.graphemes()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.filter(fn [a, b, c] -> a == c and a != b end)
  end

  defp has_bab?(addr, [a, b, a]) do
    addr
    |> String.graphemes()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.any?(fn [x, y, z] -> x == b and z == b and y == a end)
  end
end
