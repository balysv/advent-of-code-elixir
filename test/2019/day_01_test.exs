defmodule AdventOfCode.Y2019.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Y2019.Day01

  test "part1" do
    input = AdventOfCode.Input.get!(1, 2019)
    result = part1(input)

    assert result == 3270717
  end

  test "part2" do
    input = AdventOfCode.Input.get!(1, 2019)
    result = part2(input)

    assert result == 4903193
  end
end
