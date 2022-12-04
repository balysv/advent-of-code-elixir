defmodule AdventOfCode.Y2016.Day19 do
  defp prepare_input(raw), do: raw |> String.trim() |> String.to_integer()

  # https://www.youtube.com/watch?v=uCsD3ZGzMgE
  def part1(args) do
    i = args |> prepare_input()

    Stream.iterate(0, &(&1 + 1))
    |> Enum.find(fn n -> :math.pow(2, n) > i end)
    |> then(fn n -> (i - :math.pow(2, n - 1)) * 2 + 1 end)
  end

  def part2(args) do
    i = args |> prepare_input()
    # Extended sequence from simulation of '1's (thanks, Wolfram Alpha)
    seq = [
      1,
      2,
      4,
      10,
      28,
      82,
      244,
      730,
      2188,
      6562,
      19684,
      59050,
      177_148,
      531_442,
      1_594_324,
      4_782_970,
      14_348_908,
      43_046_722,
      129_140_164
    ]

    Enum.with_index(seq)
    # Find the closest smallest sequence number
    |> Enum.find(fn {n, idx} -> n > i end)
    |> then(fn
      {_, idx} ->
        last_1 = Enum.at(seq, idx - 1)
        # that many increments by '1' until '2's start
        ones = last_1 - 2
        # number of increments until our target elf count
        inc_needed = i - last_1
        # that many increments by '2' needed
        twos = max(inc_needed - ones, 0)
        1 + min(inc_needed, ones) + twos * 2
    end)
  end

  defp _simulate(elf_count) do
    0..100_000
    |> Enum.reduce_while(Enum.to_list(1..elf_count), fn
      _, [elf] ->
        {:halt, elf}

      _, elfs ->
        size = length(elfs)
        target = div(size, 2)
        {:cont, tl(List.delete_at(elfs, target)) ++ [hd(elfs)]}
    end)
  end
end
