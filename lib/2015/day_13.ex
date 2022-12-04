defmodule AdventOfCode.Y2015.Day13 do
  # Alice would gain 2 happiness units by sitting next to Bob.

  def prepare_input(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      words = line |> String.split(" ")

      {{
         hd(words),
         List.last(words) |> String.replace(".", "")
       },
       {
         Enum.at(words, 2) |> String.to_atom(),
         Enum.at(words, 3) |> String.to_integer()
       }}
    end)
    |> Enum.into(%{})
  end

  def part1(args), do: args |> prepare_input() |> find_optimal_seating()

  def part2(args), do: args |> prepare_input() |> add_yourself() |> find_optimal_seating()

  defp add_yourself(input) do
    all_names(input)
    |> Enum.reduce(input, fn name, acc ->
      acc
      |> Map.put({"Me", name}, {:gain, 0})
      |> Map.put({name, "Me"}, {:gain, 0})
    end)
  end

  defp find_optimal_seating(input) do
    all_names(input)
    |> permutations()
    |> Enum.map(fn
      seating ->
        r =
          all_pairs(seating)
          |> Enum.reduce(0, fn
            {l, r}, acc ->
              right =
                case Map.get(input, {l, r}) do
                  {:gain, value} -> value
                  {:lose, value} -> -value
                end

              left =
                case Map.get(input, {r, l}) do
                  {:gain, value} -> value
                  {:lose, value} -> -value
                end

              acc + right + left
          end)

        {seating, r}
    end)
    |> Enum.max_by(&elem(&1, 1))
  end

  defp all_names(input), do: input |> Map.keys() |> Enum.map(&elem(&1, 0)) |> Enum.uniq()

  defp all_pairs(seating) do
    pairs = Enum.chunk_every(seating, 2, 1, :discard) |> Enum.map(&List.to_tuple/1)
    [{List.last(seating), hd(seating)} | pairs]
  end

  defp permutations([]), do: [[]]

  defp permutations(list),
    do: for(elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest])
end
