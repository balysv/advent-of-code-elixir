defmodule AdventOfCode.Y2016.Day12 do
  defp prepare_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, " ")
      |> Enum.map(fn str ->
        case Integer.parse(str) do
          :error -> String.to_atom(str)
          {v, _} -> v
        end
      end)
      |> List.to_tuple()
    end)
  end

  def part1(args), do: args |> prepare_input() |> recur_p1() |> Map.get(:a)

  defp recur_p1(instrs) do
    recur(instrs, instrs, 0, %{:a => 0, :b => 0, :c => 0, :d => 0})
  end

  def part2(args), do: args |> prepare_input() |> recur_p2() |> Map.get(:a)

  defp recur_p2(instrs) do
    recur(instrs, instrs, 0, %{:a => 0, :b => 0, :c => 1, :d => 0})
  end

  defp recur([], _, _, reg), do: reg

  defp recur([{:cpy, x, r} | rest], instrs, idx, reg) do
    val = if is_integer(x), do: x, else: Map.get(reg, x)
    recur(rest, instrs, idx + 1, Map.put(reg, r, val))
  end

  defp recur([{:inc, r} | rest], instrs, idx, reg) do
    recur(rest, instrs, idx + 1, Map.update!(reg, r, &(&1 + 1)))
  end

  defp recur([{:dec, r} | rest], instrs, idx, reg) do
    recur(rest, instrs, idx + 1, Map.update!(reg, r, &(&1 - 1)))
  end

  defp recur([{:jnz, x, y} | rest], instrs, idx, reg) do
    val = if is_integer(x), do: x, else: Map.get(reg, x)

    if val != 0 do
      idx = idx + y
      recur(Enum.slice(instrs, idx..-1), instrs, idx, reg)
    else
      recur(rest, instrs, idx + 1, reg)
    end
  end
end
