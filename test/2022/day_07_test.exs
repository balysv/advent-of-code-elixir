defmodule AdventOfCode.Y2022.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day07

  test "part1" do
    input = AdventOfCode.Input.get!(7, 2022)
    result = part1(input)

    assert result == 1_648_397
  end

  test "part2" do
    input = AdventOfCode.Input.get!(7, 2022)
    result = part2(input)

    assert result == 1_815_525
  end
end
