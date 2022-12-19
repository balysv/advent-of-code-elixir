defmodule AdventOfCode.Y2022.Day18Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day18

  test "part1" do
    input = AdventOfCode.Input.get!(18, 2022)
    result = part1(input)

    assert result == 4628
  end

  test "part2" do
    input = AdventOfCode.Input.get!(18, 2022)
    result = part2(input)

    assert result == 2582
  end
end
