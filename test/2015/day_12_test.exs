defmodule AdventOfCode.Y2015.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day12

  test "part1" do
    input = AdventOfCode.Input.get!(12, 2015)
    result = part1(input)

    assert result == 111_754
  end

  test "part2" do
    input = AdventOfCode.Input.get!(12, 2015)
    result = part2(input)

    assert result == 65402
  end
end
