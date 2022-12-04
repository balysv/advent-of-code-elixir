defmodule AdventOfCode.Y2015.Day12 do
  def part1(args) do
    Jason.decode!(args)
    |> traverse_map()
  end

  def part2(args) do
    Jason.decode!(args)
    |> traverse_map(true)
  end

  defp traverse_map(map, red_check? \\ false) do
    result  =map
    |> Enum.map(fn
      {_, v} when is_integer(v) -> v
      {_, v} when is_map(v) -> traverse_map(v, red_check?)
      {_, v} when is_list(v) -> traverse_list(v, red_check?)
      {_, v} when is_binary(v) and red_check? -> if v == "red", do: :red, else: 0
      _ -> 0
    end)

    if :red in result do
      0
    else
      Enum.sum(result)
    end

  end

  defp traverse_list(list, red_check?) do
    list
    |> Enum.map(fn
      v when is_integer(v) -> v
      v when is_map(v) -> traverse_map(v, red_check?)
      v when is_list(v) -> traverse_list(v, red_check?)
      _ -> 0
    end)
    |> Enum.sum()
  end
end
