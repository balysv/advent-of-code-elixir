defmodule AdventOfCode.Y2015.Day07 do
  defp prepare_input(raw_input) do
    raw_input
    |> String.split(["\n", " -> "], trim: true)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [lfs, rhs] -> {String.split(lfs), rhs} end)
    |> Enum.map(fn
      {[var1, "AND", var2], out} -> {out, {:and, [var1, var2]}}
      {[var1, "OR", var2], out} -> {out, {:or, [var1, var2]}}
      {["NOT", var], out} -> {out, {:not, var}}
      {[var, "LSHIFT", value], out} -> {out, {:lshift, [var, String.to_integer(value)]}}
      {[var, "RSHIFT", value], out} -> {out, {:rshift, [var, String.to_integer(value)]}}
      {[value], out} -> {out, value}
    end)
    |> Enum.into(%{})
  end

  def part1(args) do
    args |> prepare_input() |> compute() |> elem(0)
  end

  def part2(args) do
    input = args |> prepare_input()
    a_value = input |> compute() |> elem(0)
    overriden_input = Map.put(input, "b", "#{a_value}")
    overriden_input |> compute() |> elem(0)
  end

  defp compute(wires) do
    value(Map.get(wires, "a"), wires, %{})
  end

  defp value({:and, [var1, var2]}, wires, ctx) do
    {v1, ctx} = value(var1, wires, ctx)
    {v2, ctx} = value(var2, wires, ctx)
    {Bitwise.band(v1, v2), ctx}
  end

  defp value({:or, [var1, var2]}, wires, ctx) do
    {v1, ctx} = value(var1, wires, ctx)
    {v2, ctx} = value(var2, wires, ctx)
    {Bitwise.bor(v1, v2), ctx}
  end

  defp value({:not, var}, wires, ctx) do
    {v, ctx} = value(var, wires, ctx)
    {Bitwise.bnot(v), ctx}
  end

  defp value({:lshift, [var, shift]}, wires, ctx) do
    {v, ctx} = value(var, wires, ctx)
    {Bitwise.<<<(v, shift), ctx}
  end

  defp value({:rshift, [var, shift]}, wires, ctx) do
    {v, ctx} = value(var, wires, ctx)
    {Bitwise.>>>(v, shift), ctx}
  end

  defp value(x, _, ctx) when is_map_key(ctx, x), do: {Map.get(ctx, x), ctx}

  defp value(x, wires, ctx) do
    case Integer.parse(x) do
      {v, _} ->
        {v, ctx}

      :error ->
        {v, ctx} = value(Map.get(wires, x), wires, ctx)
        ctx = Map.put(ctx, x, v)
        {v, ctx}
    end
  end
end
