defmodule AdventOfCode.Y2015.Day16 do
  @target %{
    "children" => 3,
    "cats" => 7,
    "samoyeds" => 2,
    "pomeranians" => 3,
    "akitas" => 0,
    "vizslas" => 0,
    "goldfish" => 5,
    "trees" => 3,
    "cars" => 2,
    "perfumes" => 1
  }

  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.replace(line, ~r/Sue [0-9]+: /, "") end)
    |> Enum.with_index()
    |> Enum.map(fn {line, idx} ->
      values =
        String.split(line, ", ", trim: true)
        |> Enum.map(&String.split(&1, ": "))
        |> Enum.map(fn [key, val] -> {key, String.to_integer(val)} end)
        |> Enum.into(%{})

      {idx, values}
    end)
    |> Enum.into(%{})
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.filter(fn {_, values} ->
      needed = MapSet.new(@target)
      got = MapSet.new(values)
      MapSet.subset?(got, needed)
    end)
    |> hd
    |> elem(0)
    |> then(&Kernel.+(&1, 1))
  end

  def part2(args) do
    args
    |> prepare_input()
    |> Enum.filter(fn {_, values} ->
      %{"cats" => cats, "trees" => trees, "pomeranians" => pomeranians, "goldfish" => goldfish} =
        @target

      equals = @target |> remove_keys() |> MapSet.new()
      got = values |> remove_keys() |> MapSet.new()

      MapSet.subset?(got, equals) and
        Map.get(values, "cats", 999) > cats and
        Map.get(values, "trees", 999) > trees and
        Map.get(values, "pomeranians", 0) < pomeranians and
        Map.get(values, "goldfish", 0) < goldfish
    end)
    |> hd
    |> elem(0)
    |> then(&Kernel.+(&1, 1))
  end

  defp remove_keys(map) do
    map
    |> Map.delete("cats")
    |> Map.delete("trees")
    |> Map.delete("pomeranians")
    |> Map.delete("goldfish")
  end
end
