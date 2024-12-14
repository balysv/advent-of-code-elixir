defmodule AdventOfCode.Y2024.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day11

  test "part1" do
    input = AdventOfCode.Input.get!(11, 2024)
    result = part1(input)
    # Many shots, implementing the logic for splitting the stones
    # was too tricky to understand
    assert result == 202_019
  end

  test "part2" do
    input = AdventOfCode.Input.get!(11, 2024)
    result = part2(input)
    # Did not finish. With many many hints in implemented caching but
    # used a shared Process cache which is terribly slow. In the end,
    # I had to rewrite it using an inline cache.
    assert result == 239_321_955_280_205
  end
end
