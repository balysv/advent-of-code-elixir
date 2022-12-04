defmodule AdventOfCode.Y2015.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day03

  test "part1" do
    input = AdventOfCode.Input.get!(3, 2015)
    result = part1(input)

    assert result == 2592
  end

  test "part2" do
    input = AdventOfCode.Input.get!(3, 2015)
    result = part2(input)

    assert result == 2360
  end
end
