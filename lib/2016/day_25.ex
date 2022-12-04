defmodule AdventOfCode.Y2016.Day25 do
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

  def part1(args) do
    instrs = args |> prepare_input()

    Stream.iterate(0, &(&1 + 1))
    |> Enum.find(fn i -> recur(instrs, i) == 10_101_010 end)
  end

  defp recur(instrs, a) do
    recur(instrs, instrs, 0, %{:a => a, :b => 0, :c => 0, :d => 0, :out => []})
  end

  defp recur(_, _, _, %{:out => res}) when length(res) == 8, do: Integer.undigits(res)

  defp recur([{:out, x} | rest], instrs, idx, reg) do
    val = if is_integer(x), do: x, else: Map.get(reg, x)
    recur(rest, instrs, idx + 1, Map.update!(reg, :out, fn a -> [val | a] end))
  end

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
    x = if is_integer(x), do: x, else: Map.get(reg, x)
    y = if is_integer(y), do: y, else: Map.get(reg, y)

    if x != 0 do
      idx = idx + y
      recur(Enum.slice(instrs, idx..-1), instrs, idx, reg)
    else
      recur(rest, instrs, idx + 1, reg)
    end
  end
end
