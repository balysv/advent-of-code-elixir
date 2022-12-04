defmodule AdventOfCode.Y2021.Day04 do
  defp prepare_input(raw_input) do
    [numbers_list | boards_list] =
      raw_input
      |> String.split("\n", trim: true)

    drawn_numbers =
      numbers_list
      |> String.split(",")

    boards =
      boards_list
      |> Enum.map(&String.split/1)
      |> Enum.chunk_every(5)
      |> Enum.map(&List.flatten/1)

    {drawn_numbers, boards}
  end

  defmodule Board do
    def mark_number(board, number) do
      board
      |> Enum.map(fn
        v when v == number -> "_" <> v
        v -> v
      end)
    end

    def is_winning(board) do
      horizontal =
        board
        |> Enum.chunk_every(5)
        |> Enum.any?(&is_winning_line/1)

      vertical =
        board
        |> then(&chunk_by_transpose(&1, 5))
        |> Enum.any?(&is_winning_line/1)

      vertical || horizontal
    end

    defp chunk_by_transpose(board, size) do
      Enum.with_index(board)
      |> Enum.reduce([[], [], [], [], []], fn
        {v, idx}, acc -> List.update_at(acc, rem(idx, size), fn l -> l ++ [v] end)
      end)
    end

    defp is_winning_line(["_" <> _, "_" <> _, "_" <> _, "_" <> _, "_" <> _]), do: true
    defp is_winning_line(_), do: false
  end

  # Entrypoint for Part1
  def part1(args) do
    {drawn_numbers, boards} = prepare_input(args)
    part1_recur(drawn_numbers, boards) |> compute_result
  end

  def part1_recur([number | rest], boards) do
    new_boards = boards |> Enum.map(&Board.mark_number(&1, number))
    winning_board = new_boards |> Enum.filter(&Board.is_winning/1)

    case winning_board do
      [] -> part1_recur(rest, new_boards)
      [board] -> {board, number}
    end
  end

  # Entrypoint for Part2
  def part2(args) do
    {drawn_numbers, boards} = prepare_input(args)
    part2_recur(drawn_numbers, boards) |> compute_result
  end

  def part2_recur([number | rest], boards) do
    new_boards = boards |> Enum.map(&Board.mark_number(&1, number))
    winning_boards = new_boards |> Enum.filter(&Board.is_winning/1)

    case winning_boards do
      [] -> part2_recur(rest, new_boards)
      [board] when length(boards) == 1 -> {board, number}
      boards -> part2_recur(rest, new_boards -- boards)
    end
  end

  defp compute_result({board, winning_number}) do
    board_sum =
      board
      |> Enum.filter(&(!String.starts_with?(&1, "_")))
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()

    board_sum * String.to_integer(winning_number)
  end
end
