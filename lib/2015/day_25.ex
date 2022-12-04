defmodule AdventOfCode.Y2015.Day25 do
  def part1(args) do
    {row, col} = args

    real_row = row + col - 1
    row_no = div(real_row * (real_row + 1), 2) - real_row + 1
    seq_no = row_no + col - 2

    1..seq_no
    |> Enum.reduce(20_151_125, fn _, acc ->
      rem(acc * 252_533, 33_554_393)
    end)
  end
end
