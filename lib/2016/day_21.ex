defmodule AdventOfCode.Y2016.Day21 do
  defp input(str) do
    str
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.map(fn {a, b} -> {b, a} end)
    |> Enum.into(%{})
  end

  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> recur(input("abcdefgh"), false)
    |> Enum.map(&elem(&1, 1))
    |> Enum.join()
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.reverse()
    |> recur(input("fbgdceah"), true)
    |> Enum.map(&elem(&1, 1))
    |> Enum.join()
  end

  defp recur([], pass, _), do: pass

  defp recur(["swap position " <> str | rest], pass, reverse?) do
    [x, y] =
      Regex.run(~r/(\d) with position (\d)/, str, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)

    recur(rest, swap(pass, x, y), reverse?)
  end

  defp recur(["swap letter " <> str | rest], pass, reverse?) do
    [x, y] =
      Regex.run(~r/([a-z]) with letter ([a-z])/, str, capture: :all_but_first)
      |> Enum.map(&index_of(pass, &1))

    recur(rest, swap(pass, x, y), reverse?)
  end

  defp recur(["move position " <> str | rest], pass, reverse?) do
    [x, y] =
      Regex.run(~r/(\d) to position (\d)/, str, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)
      |> then(fn [x, y] -> if reverse?, do: [y, x], else: [x, y] end)

    letter = Map.get(pass, x)
    pass = pass |> remove_at(x) |> insert_at(y, letter)

    recur(rest, pass, reverse?)
  end

  defp recur(["reverse positions " <> str | rest], pass, reverse?) do
    [x, y] =
      Regex.run(~r/(\d) through (\d)/, str, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)

    pass =
      pass
      |> Enum.map(fn
        {idx, l} when idx < x or idx > y -> {idx, l}
        {idx, l} -> {x + y - idx, l}
      end)
      |> Enum.into(%{})

    recur(rest, pass, reverse?)
  end

  defp recur(["rotate based on position of letter " <> letter | rest], pass, reverse?) do
    idx = index_of(pass, letter)

    steps =
      if reverse? do
        div(idx, 2) + if(rem(idx, 2) == 1 or idx == 0, do: 1, else: 5)
      else
        if idx >= 4, do: 2 + idx, else: 1 + idx
      end

    f = if reverse?, do: &rotate_left/2, else: &rotate_right/2

    recur(rest, f.(pass, steps), reverse?)
  end

  defp recur(["rotate right " <> <<steps::bytes-size(1)>> <> _ | rest], pass, reverse?) do
    steps = String.to_integer(steps)
    f = if reverse?, do: &rotate_left/2, else: &rotate_right/2
    recur(rest, f.(pass, steps), reverse?)
  end

  defp recur(["rotate left " <> <<steps::bytes-size(1)>> <> _ | rest], pass, reverse?) do
    steps = String.to_integer(steps)
    f = if reverse?, do: &rotate_right/2, else: &rotate_left/2
    recur(rest, f.(pass, steps), reverse?)
  end

  defp index_of(map, letter) do
    Enum.find(map, fn {_, l} -> l == letter end) |> elem(0)
  end

  defp remove_at(map, pos) do
    map
    |> Enum.reject(fn {idx, _} -> idx == pos end)
    |> Enum.map(fn
      {idx, l} when idx < pos -> {idx, l}
      {idx, l} -> {idx - 1, l}
    end)
    |> Enum.into(%{})
  end

  defp insert_at(map, pos, val) do
    map
    |> Enum.map(fn
      {idx, l} when idx < pos -> {idx, l}
      {idx, l} -> {idx + 1, l}
    end)
    |> Enum.into(%{})
    |> Map.put(pos, val)
  end

  defp rotate_right(map, count) do
    size = map_size(map)

    map
    |> Enum.map(fn
      {idx, l} -> {rem(idx + count, size), l}
    end)
    |> Enum.into(%{})
  end

  defp rotate_left(map, count) do
    size = map_size(map)

    map
    |> Enum.map(fn
      {idx, l} -> {rem(idx + size - count, size), l}
    end)
    |> Enum.into(%{})
  end

  defp swap(map, x, y) do
    map
    |> Map.put(x, Map.get(map, y))
    |> Map.put(y, Map.get(map, x))
  end

end
