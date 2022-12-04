defmodule AdventOfCode.Y2015.Day24Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day24

  test "part1" do
    input = AdventOfCode.Input.get!(24, 2015)
    result = part1(input)

    assert result == 11266889531
  end

  test "part2" do
    input = AdventOfCode.Input.get!(24, 2015)
    result = part2(input)

    assert result == 77387711
  end
end
