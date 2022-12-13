defmodule AdventOfCode.Y2022.Day13 do
  defp prepare_input(args) do
    args
    |> String.split(["\n\n", "\n"], trim: true)
    |> Enum.map(fn line -> line |> Code.eval_string() |> elem(0) end)
  end

  # start clause
  defp compare(l, r) when is_list(l) and is_list(r), do: do_compare(l, r, :unknown)

  # end clause
  defp do_compare(_, _, equal?) when is_boolean(equal?), do: equal?

  # ints
  defp do_compare([same | l_rest], [same | r_rest], equal?) when is_integer(same),
    do: do_compare(l_rest, r_rest, equal?)

  defp do_compare([l | _], [r | _], _equal?) when is_integer(l) and is_integer(r), do: l < r

  # lists
  defp do_compare([], [], equal?), do: equal?
  defp do_compare([], [_r | _], _equal?), do: true
  defp do_compare([_l | _], [], _equal?), do: false
  defp do_compare([l], [r], equal?), do: do_compare(l, r, equal?)

  defp do_compare([l | l_rest], [r | r_rest], equal?) do
    equal? = do_compare(l, r, equal?)
    do_compare(l_rest, r_rest, equal?)
  end

  # list vs int
  defp do_compare(l, r, equal?) when is_list(l) and is_integer(r), do: do_compare(l, [r], equal?)
  defp do_compare(l, r, equal?) when is_list(r) and is_integer(l), do: do_compare([l], r, equal?)

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.chunk_every(2)
    |> Enum.with_index()
    |> Enum.filter(fn {[l, r], _} -> compare(l, r) end)
    |> Enum.map(fn {_, idx} -> idx + 1 end)
    |> Enum.sum()
  end

  def part2(args) do
    sorted =
      args
      |> prepare_input()
      |> Enum.concat([[[2]], [[6]]])
      |> Enum.sort(fn l, r ->
        case compare(l, r) do
          :unknown -> false
          v -> v
        end
      end)

    divider_1 = Enum.find_index(sorted, &match?([[2]], &1)) + 1
    divider_2 = Enum.find_index(sorted, &match?([[6]], &1)) + 1

    divider_1 * divider_2
  end
end
