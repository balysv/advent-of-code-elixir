defmodule AdventOfCode.Y2017.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Y2017.Day03

  test "part1" do
    input = AdventOfCode.Input.get!(3, 2017)
    result = part1(input)

    assert result == 480
  end

  test "part2" do
    input = AdventOfCode.Input.get!(3, 2017)
    result = part2(input)

    assert result == 349975
  end
end
