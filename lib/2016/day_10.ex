defmodule AdventOfCode.Y2016.Day10 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, acc ->
      if String.starts_with?(line, "bot") do
        [name, low, high] =
          Regex.run(~r/(bot [0-9]+) gives low to (.*) and high to (.*)$/, line,
            capture: :all_but_first
          )

        v = [low: low, high: high]
        acc |> Map.update(name, v, fn e -> Keyword.merge(e, v) end)
      else
        [value, name] = Regex.run(~r/value ([0-9]+) goes to (.*)$/, line, capture: :all_but_first)
        acc |> update_values(name, String.to_integer(value))
      end
    end)
  end

  defp update_values(bots, name, value) do
    curr = Map.get(bots, name, [])
    vals = Keyword.get(curr, :values, [])

    if value not in vals do
      new_vals = [values: vals ++ [value]]
      Map.update(bots, name, new_vals, fn e -> Keyword.merge(e, new_vals) end)
    else
      bots
    end
  end

  def part1(args) do
    args
    |> prepare_input()
    |> propagate()
    |> Enum.find(fn
      {_, kv} ->
        vals = Keyword.get(kv, :values, [])
        [61, 17] -- vals == []
    end)
    |> elem(0)
  end

  def part2(args) do
    args
    |> prepare_input()
    |> propagate()
    |> Enum.filter(fn {name, _} -> name in ["output 0", "output 1", "output 2"] end)
    |> Enum.flat_map(fn {_, [values: vals]} -> vals end)
    |> Enum.product()
  end

  defp propagate(bots) do
    1..100
    |> Enum.reduce(bots, fn _, bots ->
      bots
      |> Enum.filter(fn {name, v} ->
        length(Keyword.get(v, :values, [])) == 2 and !String.starts_with?(name, "output")
      end)
      |> Enum.reduce(bots, fn
        {_, [low: low, high: high, values: vals]}, acc ->
          {min, max} = Enum.min_max(vals)

          acc
          |> update_values(low, min)
          |> update_values(high, max)
      end)
    end)
  end
end
