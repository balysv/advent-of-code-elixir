defmodule AdventOfCode.Y2019.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Y2019.Day01

  test "part1" do
    input = AdventOfCode.Input.get!(1, 2019)
    result = part1(input)

    assert result == 3_270_717
  end

  test "part2" do
    input = AdventOfCode.Input.get!(1, 2019)
    result = part2(input)

    assert result == 4_903_193
  end
end
