defmodule AdventOfCode.Y2022.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day11

  test "part1" do
    input = AdventOfCode.Input.get!(11, 2022)
    result = part1(input)

    assert result == 55216
  end

  test "part2" do
    input = AdventOfCode.Input.get!(11, 2022)
    result = part2(input)

    assert result == 12_848_882_750
  end
end
