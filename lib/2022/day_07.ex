defmodule AdventOfCode.Y2022.Day07 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.concat(["$ cd .."])
    |> recur(%{stack: [], sizes: []})
    |> Enum.map(&elem(&1, 1))
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.filter(&Kernel.<=(&1, 100_000))
    |> Enum.sum()
  end

  def part2(args) do
    dir_sizes = prepare_input(args)
    used_space = Enum.max(dir_sizes)
    missing_space = 30_000_000 - (70_000_000 - used_space)

    dir_sizes
    |> Enum.sort(:asc)
    |> Enum.find(&Kernel.>=(&1, missing_space))
  end

  defp recur([], %{stack: [prev], sizes: sizes}), do: [prev | sizes]

  defp recur(["$ cd .." | rem], %{
         stack: [{_prev_dir, prev_size} = prev, {curr_dir, curr_size} | stack],
         sizes: sizes
       }) do
    recur(rem, %{stack: [{curr_dir, curr_size + prev_size} | stack], sizes: [prev | sizes]})
  end

  defp recur(["$ cd " <> dir_name | rem], %{stack: stack, sizes: sizes}) do
    recur(rem, %{stack: [{dir_name, 0} | stack], sizes: sizes})
  end

  defp recur(["$ ls" | rem], acc), do: recur(rem, acc)

  defp recur(["dir" <> _dir_name | rem], acc), do: recur(rem, acc)

  defp recur([file | rem], %{stack: [{curr_dir, curr_size} | stack]} = acc) do
    [size, _filename] = String.split(file, " ")
    file_size = String.to_integer(size)
    recur(rem, %{acc | stack: [{curr_dir, curr_size + file_size} | stack]})
  end
end
