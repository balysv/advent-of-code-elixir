defmodule AdventOfCode.Y2024.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day06

  test "part1" do
    input = AdventOfCode.Input.get!(6, 2024)
    result = part1(input)
    # Many shots as it mixed up what's left and right
    assert result == 4939
  end

  test "part2" do
    input = AdventOfCode.Input.get!(6, 2024)
    result = part2(input)
    # 1 shot but rather slow
    assert result == 1434
  end
end
