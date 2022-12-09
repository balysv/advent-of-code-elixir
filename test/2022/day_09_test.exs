defmodule AdventOfCode.Y2022.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day09

  test "part1" do
    input = AdventOfCode.Input.get!(9, 2022)
    result = part1(input)

    assert result == 6087
  end

  test "part2" do
    input = AdventOfCode.Input.get!(9, 2022)
    result = part2(input)

    assert result == 2493
  end
end
