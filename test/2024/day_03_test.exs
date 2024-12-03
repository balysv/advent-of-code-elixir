defmodule AdventOfCode.Y2024.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day03

  test "part1" do
    input = AdventOfCode.Input.get!(3, 2024)
    result = part1(input)
    # 1 shot
    assert result == 167_650_499
  end

  test "part2" do
    input = AdventOfCode.Input.get!(3, 2024)
    result = part2(input)
    # many many shots; missed a crucial bug that
    # the enabled flag was not being passed between
    # lines.
    assert result == 95_846_796
  end
end
