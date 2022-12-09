defmodule AdventOfCode.Y2022.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day08

  test "part1" do
    input = AdventOfCode.Input.get!(8, 2022)
    result = part1(input)

    assert result == 1560
  end

  test "part2" do
    input = AdventOfCode.Input.get!(8, 2022)
    result = part2(input)
    assert result == 252_000
  end
end
