defmodule AdventOfCode.Y2024.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day05

  test "part1" do
    input = AdventOfCode.Input.get!(5, 2024)
    result = part1(input)
    # 1 shot
    assert result == 4905
  end

  test "part2" do
    input = AdventOfCode.Input.get!(5, 2024)
    result = part2(input)
    # 1 shot
    assert result == 6204
  end
end
