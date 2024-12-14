defmodule AdventOfCode.Y2024.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day14

  test "part1" do
    input = AdventOfCode.Input.get!(14, 2024)
    result = part1(input)
    # 1 shot
    assert result == 209_409_792
  end

  @tag :skip
  test "part2" do
    input = AdventOfCode.Input.get!(14, 2024)
    result = part2(input)
    # Can't work as we needed manual inspection and
    # "guessed" tree detection algorithms never worked
    assert result == 8006
  end
end
