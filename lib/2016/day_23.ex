defmodule AdventOfCode.Y2016.Day23 do
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

  def part1(args), do: args |> prepare_input() |> recur(7) |> Map.get(:a)

  def part2(args), do: args |> prepare_input() |> recur(12) |> Map.get(:a)

  defp recur(instrs, a) do
    recur(instrs, instrs, 0, %{:a => a, :b => 0, :c => 0, :d => 0})
  end

  defp recur([], _, _, reg), do: reg

  defp recur([{:cpy, _, r} | rest], instrs, idx, reg) when is_integer(r) do
    recur(rest, instrs, idx + 1, reg)
  end

  defp recur([{:cpy, x, r} | rest], instrs, idx, reg) do
    val = if is_integer(x), do: x, else: Map.get(reg, x)
    recur(rest, instrs, idx + 1, Map.put(reg, r, val))
  end

  defp recur([{:inc, r} | rest], instrs, idx, reg) when is_integer(r) do
    recur(rest, instrs, idx + 1, reg)
  end

  defp recur([{:inc, r} | rest], instrs, idx, reg) do
    recur(rest, instrs, idx + 1, Map.update!(reg, r, &(&1 + 1)))
  end

  defp recur([{:dec, r} | rest], instrs, idx, reg) when is_integer(r) do
    recur(rest, instrs, idx + 1, reg)
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

  defp recur([{:tgl, x} | rest], instrs, idx, reg) do
    val = if is_integer(x), do: x, else: Map.get(reg, x)
    target = idx + val

    if target >= length(instrs) do
      recur(rest, instrs, idx + 1, reg)
    else
      toggled =
        case Enum.at(instrs, target) do
          {:inc, r} -> {:dec, r}
          {_, r} -> {:inc, r}
          {:jnz, a, b} -> {:cpy, a, b}
          {_, a, b} -> {:jnz, a, b}
        end

      {f, s} = Enum.split(instrs, target)
      instrs = f ++ [toggled] ++ tl(s)
      rest = Enum.slice(instrs, (idx + 1)..-1)

      recur(rest, instrs, idx + 1, reg)
    end
  end
end
