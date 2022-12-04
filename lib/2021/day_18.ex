defmodule AdventOfCode.Y2021.Day18 do
  defmodule Parser do
    def parse(string), do: do_parse(string) |> elem(0)

    defp do_parse("[" <> rest) do
      {l, rest} = do_parse(rest)
      {r, rest} = do_parse(rest)
      {[l, r], rest}
    end

    defp do_parse("," <> rest), do: do_parse(rest)
    defp do_parse("]" <> rest), do: do_parse(rest)

    defp do_parse(<<digit::1-bytes>> <> rest) do
      {String.to_integer(digit), rest}
    end
  end

  defmodule Reducer do
    def reduce(tree) do
      {exploded?, _, tree, _} = explode(tree, 0)
      if exploded? do
        reduce(tree)
      else
        {split?, tree} = split(tree)
        if split?, do: reduce(tree), else: tree
      end
    end

    defguardp splitting?(e) when is_integer(e) and e >= 10
    defp split(e) when splitting?(e) do
      v = trunc(e / 2)
      {true, [v, e - v]}
    end
    defp split(e) when is_integer(e), do: {false, e}
    defp split([l, r]) do
      {split?, l} = split(l)

      if split? do
        {split?, [l, r]}
      else
        {split?, r} = split(r)
        {split?, [l, r]}
      end
    end

    defguardp exploding?(l, r, depth) when is_integer(l) and is_integer(r) and depth >= 4
    defp explode([l, r], depth) when exploding?(l, r, depth), do: {true, l, 0, r}
    defp explode([l, r], depth) do
      {exploded?, lv, l, rv} = explode(l, depth + 1)

      if exploded? do
        {exploded?, lv, [l, propogate(r, rv, :left)], 0}
      else
        {exploded?, lv, r, rv} = explode(r, depth + 1)
        if exploded? do
          {exploded?, 0, [propogate(l, lv, :right), r], rv}
        else
          {exploded?, lv, [l, r], rv}
        end
      end
    end
    defp explode(e, _), do: {false, 0, e, 0}

    defp propogate([l, r], v, :left), do: [propogate(l, v, :left), r]
    defp propogate([l, r], v, :right), do: [l, propogate(r, v, :right)]
    defp propogate(e, v, _), do: e + v
  end

  defp prepare_input(raw_input) do
    raw_input |> String.split("\n", trim: true)
  end

  defmodule Magnitude do
    def compute([l, r]), do: 3 * compute(l) + 2 * compute(r)
    def compute(e), do: e
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.map(&Parser.parse/1)
    |> Enum.reduce(&Reducer.reduce([&2, &1]))
    |> Magnitude.compute()
  end

  def part2(args) do
    numbers =
      args
      |> prepare_input()
      |> Enum.map(&Parser.parse/1)

    magnitudes =
      for a <- numbers, b <- numbers, a != b do
        Reducer.reduce([a, b]) |> Magnitude.compute()
      end

    Enum.max(magnitudes)
  end
end
