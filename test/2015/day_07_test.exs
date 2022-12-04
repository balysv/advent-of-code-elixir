defmodule AdventOfCode.Y2015.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day07

  test "part1" do
    input = AdventOfCode.Input.get!(7, 2015)
    result = part1(input)

    assert result == 3176
  end

  @tag :skip
  test "part2" do
    input = AdventOfCode.Input.get!(7, 2015)
    result = part2(input)

    assert result == 14710
  end
end
