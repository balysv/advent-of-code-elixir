defmodule AdventOfCode.Y2022.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day02

  test "part1" do
    input = AdventOfCode.Input.get!(2, 2022)
    result = part1(input)

    assert result == 11475
  end

  test "part2" do
    input = AdventOfCode.Input.get!(2, 2022)
    result = part2(input)

    assert result == 16862
  end
end
