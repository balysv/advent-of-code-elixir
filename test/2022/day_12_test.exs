defmodule AdventOfCode.Y2022.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day12

  test "part1" do
    input = AdventOfCode.Input.get!(12, 2022)
    result = part1(input)

    assert result == 468
  end

  test "part2" do
    input = AdventOfCode.Input.get!(12, 2022)
    result = part2(input)

    assert result == 459
  end
end
