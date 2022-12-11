defmodule AdventOfCode.Y2022.Day11 do
  defp prepare_input(args) do
    args
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn lines ->
      [monkey, items, op, test, tr, fl] =
        String.split(
          lines,
          [
            "Monkey ",
            "  Starting items: ",
            ":",
            "  Operation: ",
            "  Test: divisible by ",
            "    If true: throw to monkey ",
            "    If false: throw to monkey ",
            "\n"
          ],
          trim: true
        )

      starting_items =
        items
        |> String.split(", ", trim: true)
        |> Enum.map(&String.to_integer/1)

      {monkey,
       %{
         id: monkey,
         items: starting_items,
         op: op,
         div_test: String.to_integer(test),
         true_target: tr,
         false_target: fl,
         count: 0
       }}
    end)
    |> Map.new()
  end

  defp find_target(monkey, item) do
    if rem(item, monkey.div_test) == 0,
      do: monkey.true_target,
      else: monkey.false_target
  end

  defp add_item(monkeys, id, item) do
    items = get_in(monkeys, [id, :items])
    items = [item | items]
    put_in(monkeys, [id, :items], items)
  end

  defp remove_items(monkeys, id) do
    put_in(monkeys, [id, :items], [])
  end

  defp update_count(monkeys, id, items) do
    count = get_in(monkeys, [id, :count])
    count = count + length(items)
    put_in(monkeys, [id, :count], count)
  end

  defp simulate(monkeys, count, worry_fn) do
    divisor = Enum.reduce(monkeys, 1, fn {_, %{div_test: div}}, acc -> acc * div end)

    1..count
    |> Enum.reduce(monkeys, fn _, monkeys ->
      monkeys
      |> Map.keys()
      |> Enum.reduce(monkeys, fn
        id, all ->
          monkey = Map.get(all, id)

          monkey.items
          |> Enum.reduce(all, fn item, all ->
            item = worry_fn.(monkey, item, divisor)
            target = find_target(monkey, item)
            add_item(all, target, item)
          end)
          |> remove_items(id)
          |> update_count(id, monkey.items)
      end)
    end)
    |> Enum.map(fn {_, %{count: count}} -> count end)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  defp compute_worry_p1(monkey, item, _) do
    {new, _} = Code.eval_string(monkey.op, old: item)
    div(new, 3)
  end

  defp compute_worry_p2(monkey, item, divisor) do
    {new, _} = Code.eval_string(monkey.op, old: item)
    rem(new, divisor)
  end

  def part1(args) do
    args
    |> prepare_input()
    |> simulate(20, &compute_worry_p1/3)
  end

  def part2(args) do
    args
    |> prepare_input()
    |> simulate(10000, &compute_worry_p2/3)
  end
end
