defmodule AdventOfCode.Y2015.Day17Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day17

  test "part1" do
    input = AdventOfCode.Input.get!(17, 2015)
    result = part1(input)

    assert result == 1304
  end

  test "part2" do
    input = AdventOfCode.Input.get!(17, 2015)
    result = part2(input)

    assert result == 18
  end
end
