defmodule AdventOfCode.Y2021.Day14 do
  defp prepare_input(raw_input) do
    [template | raw_rules] = raw_input
      |> String.split(["\n", "\n\n"], trim: true)

    rules = raw_rules
      |> Enum.map(fn s -> String.split(s, " -> ") |> Enum.map(&String.to_charlist/1) end)
      |> Enum.map(&List.to_tuple/1)
      |> Enum.into(%{})

    {template |> String.to_charlist(), rules}
  end

  def part1(args) do
    {template, rules} = prepare_input(args)

    {{_, min}, {_, max}} = 1..10
      |> Enum.reduce(template, fn _, acc -> brute_force_step(acc, rules) end)
      |> Enum.frequencies()
      |> Enum.min_max_by(&elem(&1, 1))

    max - min
  end

  defp brute_force_step(template, rules) do
    Stream.chunk_every(template, 2, 1, :discard)
    |> Enum.reduce([hd(template)], fn pair, acc ->
      [_, last] = pair
      [middle] = Map.get(rules, pair, '')
      [last, middle | acc]
    end)
    |> Enum.reverse()
  end

  def part2(args) do
    {template, rules} = prepare_input(args)
    pairs = template
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.frequencies()

    {{_, min}, {_, max}} = 1..40
      |> Enum.reduce(pairs, fn _, acc -> step(acc, rules) end)
      |> count_letters()
      |> Enum.min_max_by(&elem(&1, 1))

    max - min
  end

  def bigboy(args) do
    {template, rules} = prepare_input(args)
    pairs = template
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.frequencies()

    {{_, min}, {_, max}} = 1..100000
      |> Enum.reduce(pairs, fn
        c, acc ->
          if rem(c, 1000) == 0, do: IO.puts("#{c}")
          step(acc, rules)
      end)
      |> count_letters()
      |> Enum.min_max_by(&elem(&1, 1))

    max - min
  end

  defp step(pairs, rules) do
    Map.keys(pairs)
    |> Enum.filter(&Map.has_key?(rules, &1))
    |> Enum.reduce(%{}, fn
      [f, s] = pair, new_pairs ->
        freq = Map.get(pairs, pair, 0)
        [new_letter] = Map.get(rules, pair)

        new_pairs
        |> Map.update([f, new_letter], freq, &(&1 + freq))
        |> Map.update([new_letter, s], freq, &(&1 + freq))
    end)
  end

  def count_letters(pairs) do
    pairs
    |> Enum.map(fn {[_ | r], count} -> {r, count} end)
    |> Enum.reduce(%{}, fn {key, count}, map ->
      Map.update(map, key, count, &(&1 + count))
    end)
  end
end
