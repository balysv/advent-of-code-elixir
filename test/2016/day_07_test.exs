defmodule AdventOfCode.Y2016.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day07

  test "part1" do
    input = AdventOfCode.Input.get!(7, 2016)
    result = part1(input)

    assert result == 115
  end

  test "part2" do
    input = AdventOfCode.Input.get!(7, 2016)
    result = part2(input)

    assert result == 231
  end
end
