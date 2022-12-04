defmodule AdventOfCode.Y2021.Day07 do
  defp prepare_input(raw_input) do
    String.split(raw_input, ",", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  def part1(args) do
    input = prepare_input(args)
    alignment_pos = floor(Statistics.median(input))

    input
    |> Enum.map(&abs(&1 - alignment_pos))
    |> Enum.sum()
  end

  def part2(args) do
    input = prepare_input(args)
    {min, max} = Enum.min_max(input)

    result =
      min..max
      |> Enum.map(fn idx ->
        input
        |> Enum.map(fn pos ->
          diff = abs(pos - idx)
          div(diff * (diff + 1), 2)
        end)
        |> Enum.sum()
      end)
      |> Enum.min()

    result
  end

  def big_boy(args) do
    input = prepare_input(args)

    alignment_pos = round(Statistics.mean(input))

    input
    |> Stream.map(fn pos ->
      diff = abs(pos - alignment_pos)
      div(diff * (diff + 1), 2)
    end)
    |> Enum.sum()
  end


  def big_boy_parallel(args) do
    input = prepare_input(args)

    alignment_pos = round(Statistics.mean(input))

    input
    |> PelemayFp.map(fn pos ->
      diff = abs(pos - alignment_pos)
      div(diff * (diff + 1), 2)
    end, div(length(input), 8))
    |> Enum.sum()
  end

  def big_boy_parallel_2(args) do
    input = prepare_input(args)

    alignment_pos = round(Statistics.mean(input))
    chunk_size = div(length(input), 8)

    input
    |> Stream.chunk_every(chunk_size)
    |> Stream.map(fn chunk ->
      Task.async(fn ->
        chunk
        |> Enum.map(fn pos ->
          diff = abs(pos - alignment_pos)
          div(diff * (diff + 1), 2)
        end)
        |> Enum.sum()
      end)
    end)
    |> Enum.map(&Task.await/1)
    |> List.flatten
    |> Enum.sum()
  end
end
