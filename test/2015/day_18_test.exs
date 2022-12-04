defmodule AdventOfCode.Y2015.Day18Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day18

  test "part1" do
    input = AdventOfCode.Input.get!(18, 2015)
    result = part1(input)

    assert result == 821
  end

  test "part2" do
    input = AdventOfCode.Input.get!(18, 2015)
    result = part2(input)

    assert result == 886
  end
end
