defmodule AdventOfCode.Y2017.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Y2017.Day07

  test "part1" do
    input = AdventOfCode.Input.get!(7, 2017)
    result = part1(input)

    assert result == "gmcrj"
  end

  test "part2" do
    input = AdventOfCode.Input.get!(7, 2017)
    result = part2(input)

    assert result == 2
  end
end
