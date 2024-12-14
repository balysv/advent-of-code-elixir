defmodule AdventOfCode.Y2024.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day13

  test "part1" do
    input = AdventOfCode.Input.get!(13, 2024)
    result = part1(input)
    # 1 shot
    assert result == 37128
  end

  test "part2" do
    input = AdventOfCode.Input.get!(13, 2024)
    result = part2(input)
    # Update with actual result
    assert result == 74_914_228_471_331
  end
end
