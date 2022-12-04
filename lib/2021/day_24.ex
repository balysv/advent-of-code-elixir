defmodule AdventOfCode.Y2021.Day24 do
  use Memoize

  def prepare_input(raw) do
    raw |> String.split("inp w\n") |> Enum.map(&String.split(&1, "\n", trim: true)) |> tl()
  end

  # def part1(args) do
  #   instructions = args |> prepare_input()

  #   99_999_999_999_999..10_000000000000
  #   # 99_999_999_999_999..99_999_999_999_900
  #   |> Stream.map(&Integer.digits/1)
  #   |> Stream.reject(fn digits -> 0 in digits end)
  #   |> Stream.with_index()
  #   |> Stream.reject(fn {digits, idx} ->
  #     if rem(idx, 100000) == 0, do: IO.puts("#{idx}")

  #     try do
  #       result = recur(instructions, digits, %{"w" => 0, "x" => 0, "y" => 0, "z" => 0})
  #       result != 0
  #     rescue
  #       ArithmeticError -> true
  #     end
  #   end)
  #   |> Enum.take(1)
  # end

  @inputs [9, 8, 7, 6, 5, 4, 3, 2, 1]

  def part1(args) do
    args
    |> prepare_input()
    |> solve(:desc)
    |> Enum.min_max_by(fn {k, _} -> Integer.undigits(k) end)
  end

  def part2(args) do
    args
    |> prepare_input()
    |> solve(:asc)
    |> Enum.min_max_by(fn {k, _} -> Integer.undigits(k) end)
  end

  defp solve(instructions, direction) do
    initial_state = %{[] => %{"w" => 0, "x" => 0, "y" => 0, "z" => 0}}

    instructions
    |> Enum.with_index()
    |> Enum.reduce(initial_state, fn {batch, idx}, state ->
      IO.puts("Handling Batch #{idx}")
      IO.inspect(map_size(state))

      state
      |> Enum.sort_by(fn {digits, _} -> digits end, direction)
      |> Stream.flat_map(fn {digits, reg} ->
        @inputs
        |> Enum.map(fn i ->
          try do
            reg = Map.put(reg, "w", i)
            reg = recur(batch, reg)
            if idx != 13 or Map.get(reg, "z") == 0, do: {digits ++ [i], reg}, else: false
          rescue
            ArithmeticError -> false
          end
        end)
        |> Enum.reject(fn v -> !v end)
      end)
      |> Stream.uniq_by(fn {_, v} -> v end)
      |> Enum.into(%{})
    end)
  end

  defp recur([], reg), do: reg

  defp recur(["add " <> <<a::bytes-size(1)>> <> " " <> b | rest], reg) do
    value =
      case Integer.parse(b) do
        :error -> Map.get(reg, a) + Map.get(reg, b)
        {val, _} -> Map.get(reg, a) + val
      end

    reg = Map.put(reg, a, value)
    recur(rest, reg)
  end

  defp recur(["mul " <> <<a::bytes-size(1)>> <> " " <> b | rest], reg) do
    value =
      case Integer.parse(b) do
        :error -> Map.get(reg, a) * Map.get(reg, b)
        {val, _} -> Map.get(reg, a) * val
      end

    reg = Map.put(reg, a, value)
    recur(rest, reg)
  end

  defp recur(["div " <> <<a::bytes-size(1)>> <> " " <> b | rest], reg) do
    value =
      case Integer.parse(b) do
        :error -> div(Map.get(reg, a), Map.get(reg, b))
        {val, _} -> div(Map.get(reg, a), val)
      end

    reg = Map.put(reg, a, value)
    recur(rest, reg)
  end

  defp recur(["mod " <> <<a::bytes-size(1)>> <> " " <> b | rest], reg) do
    if a < 0, do: raise(ArithmeticError)

    value =
      case Integer.parse(b) do
        :error ->
          val = Map.get(reg, b)
          if val <= 0, do: raise(ArithmeticError), else: rem(Map.get(reg, a), val)

        {val, _} ->
          if val <= 0, do: raise(ArithmeticError), else: rem(Map.get(reg, a), val)
      end

    reg = Map.put(reg, a, value)
    recur(rest, reg)
  end

  defp recur(["eql " <> <<a::bytes-size(1)>> <> " " <> b | rest], reg) do
    value =
      case Integer.parse(b) do
        :error -> Map.get(reg, a) == Map.get(reg, b)
        {val, _} -> Map.get(reg, a) == val
      end

    reg = Map.put(reg, a, if(value, do: 1, else: 0))
    recur(rest, reg)
  end
end
