defmodule AdventOfCode.Y2016.Day14 do
  def part1(args), do: solve(args, &hash/2)

  def part2(args), do: solve(args, &super_hash/2)

  defp solve(input, hash_fn) do
    0..100_000
    |> Enum.reduce_while({[], 0}, fn i, {acc, count} ->
      hash = hash_fn.(input, i)

      keys =
        case Regex.run(~r/(.)\1{4}/, hash, capture: :all_but_first) do
          nil -> []
          matches -> Enum.filter(acc, fn {char, _} -> Enum.any?(matches, &(char == &1)) end)
        end

      acc =
        case Regex.run(~r/(.)\1{2}/, hash, capture: :all_but_first) do
          nil -> acc
          chars -> Enum.reduce(chars, acc, fn c, a -> [{c, i} | a] end)
        end

      count = count + length(keys)

      if count < 64 do
        acc = Enum.reject(acc, fn {_, idx} -> idx + 1000 <= i end)
        {:cont, {acc, count}}
      else
        {:halt, Enum.at(keys, count - 64)}
      end
    end)
    |> elem(1)
  end

  defp hash(prefix, number), do: hash(prefix <> Integer.to_string(number))

  defp super_hash(prefix, number) do
    Enum.reduce(1..2016, hash(prefix, number), fn _, acc -> hash(acc) end)
  end

  defp hash(str), do: :crypto.hash(:md5, str) |> Base.encode16() |> String.downcase()
end
