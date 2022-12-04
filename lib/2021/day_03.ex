defmodule AdventOfCode.Y2021.Day03 do
  def part1(args) do
    input =
      prepare_input(args)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)

    gamma_rate(input) * epsilon_rate(input)
  end

  defp gamma_rate(input), do: input |> Enum.map(&most_common_bit/1) |> binary_list_to_int
  defp epsilon_rate(input), do: input |> Enum.map(&least_common_bit/1) |> binary_list_to_int

  def part2(args) do
    input = prepare_input(args)
    oxygen(input) * co2(input)
  end

  defp oxygen(input), do: input |> find_bytes_by(&most_common_bit/1) |> binary_list_to_int
  defp co2(input), do: input |> find_bytes_by(&least_common_bit/1) |> binary_list_to_int

  defp find_bytes_by(list, bit_function), do: do_find_bytes_by(list, 0, bit_function)

  defp do_find_bytes_by([value], _, _), do: value

  defp do_find_bytes_by(list, position, bit_function) do
    bit =
      list
      |> Enum.map(fn i -> Enum.at(i, position) end)
      |> then(bit_function)

    filtered = Enum.filter(list, fn v -> Enum.at(v, position) == bit end)
    do_find_bytes_by(filtered, position + 1, bit_function)
  end

  defp prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  defp most_common_bit(list) do
    case(Enum.frequencies(list)) do
      %{"0" => zeroes, "1" => ones} when zeroes > ones -> "0"
      _ -> "1"
    end
  end

  defp least_common_bit(list) do
    case(Enum.frequencies(list)) do
      %{"0" => zeroes, "1" => ones} when zeroes > ones -> "1"
      _ -> "0"
    end
  end

  defp binary_list_to_int(list) do
    list
    |> Enum.join("")
    |> Integer.parse(2)
    |> elem(0)
  end
end
