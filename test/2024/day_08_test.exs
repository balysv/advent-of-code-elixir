defmodule AdventOfCode.Y2024.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Y2024.Day08

  test "part1" do
    input = AdventOfCode.Input.get!(8, 2024)
    result = part1(input)
    # Many shots as the coordinate calculation logic
    # was very off trying to do vector math instead
    # of simply adding coordinates.
    assert result == 293
  end

  test "part2" do
    input = AdventOfCode.Input.get!(8, 2024)
    result = part2(input)
    # 1 shot
    assert result == 934
  end
end
