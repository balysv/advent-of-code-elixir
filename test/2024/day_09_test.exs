defmodule AdventOfCode.Y2024.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day09

  @tag skip: true
  test "part1" do
    input = AdventOfCode.Input.get!(9, 2024)
    result = part1(input)
    # Update with actual result
    assert result == 6_385_338_159_127
  end

  @tag skip: true
  test "part2" do
    input = AdventOfCode.Input.get!(9, 2024)
    result = part2(input)
    assert result == 6_415_163_624_282
  end
end
