defmodule AdventOfCode.Y2015.Day08 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      {post, _} = Code.eval_string(line)
      String.length(line) - String.length(post)
    end)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      post = Macro.to_string(quote do: unquote(line))
      String.length(post) - String.length(line)
    end)
    |> Enum.sum()
  end
end
