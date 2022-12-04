defmodule AdventOfCode.Y2015.Day23 do
  def part1(args) do
    instrs = args |> String.split("\n", trim: true)
    registry = %{"a" => 0, "b" => 0}
    process(0, instrs, registry)
  end

  def part2(args) do
    instrs = args |> String.split("\n", trim: true)
    registry = %{"a" => 1, "b" => 0}
    process(0, instrs, registry)
  end

  defp process(idx, instrs, reg = %{"a" => a, "b" => b}) do
    case Enum.at(instrs, idx, :end) do
      "hlf " <> var -> process(idx + 1, instrs, Map.update(reg, var, nil, fn v -> div(v, 2) end))
      "tpl " <> var -> process(idx + 1, instrs, Map.update(reg, var, nil, fn v -> v * 3 end))
      "inc " <> var -> process(idx + 1, instrs, Map.update(reg, var, nil, fn v -> v + 1 end))
      "jio a, " <> o when a == 1 -> process(idx + offset(o), instrs, reg)
      "jie a, " <> o when rem(a, 2) == 0 -> process(idx + offset(o), instrs, reg)
      "jio b, " <> o when b == 1 -> process(idx + offset(o), instrs, reg)
      "jie b, " <> o when rem(b, 2) == 0 -> process(idx + offset(o), instrs, reg)
      "jio " <> _r -> process(idx + 1, instrs, reg)
      "jie " <> _r -> process(idx + 1, instrs, reg)
      "jmp " <> o -> process(idx + offset(o), instrs, reg)
      :end -> Map.get(reg, "b")
    end
  end

  defp offset(str), do: Integer.parse(str) |> elem(0)
end
