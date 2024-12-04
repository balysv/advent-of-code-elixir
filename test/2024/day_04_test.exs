defmodule AdventOfCode.Y2024.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day04

  test "part1" do
    input = AdventOfCode.Input.get!(4, 2024)
    result = part1(input)
    # 1 shot
    assert result == 2462
  end

  test "part2" do
    input = AdventOfCode.Input.get!(4, 2024)
    result = part2(input)
    # 1 shot
    assert result == 1877
  end
end
