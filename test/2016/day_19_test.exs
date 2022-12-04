defmodule AdventOfCode.Y2016.Day19Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day19

  test "part1" do
    input = AdventOfCode.Input.get!(19, 2016)
    result = part1(input)

    assert result == 1816277.0
  end

  test "part2" do
    input = AdventOfCode.Input.get!(19, 2016)
    result = part2(input)

    assert result == 1410967
  end
end
