defmodule AdventOfCode.Y2015.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day02

  test "part1" do
    input = AdventOfCode.Input.get!(2, 2015)
    result = part1(input)
    assert result == 1_586_300
  end

  test "part2" do
    input = AdventOfCode.Input.get!(2, 2015)
    result = part2(input)

    assert result == 3737498
  end
end
