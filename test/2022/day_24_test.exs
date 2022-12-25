defmodule AdventOfCode.Y2022.Day24Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day24

  test "part1" do
    input = AdventOfCode.Input.get!(24, 2022)

    result = part1(input)

    assert result == 292
  end

  test "part2" do
    input = AdventOfCode.Input.get!(24, 2022)
    result = part2(input)

    assert result == 816
  end
end
