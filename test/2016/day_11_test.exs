defmodule AdventOfCode.Y2016.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day11

  @tag :skip
  test "part1" do
    input = AdventOfCode.Input.get!(11, 2016)
    result = part1(input)

    assert result == 31
  end

  @tag timeout: :infinity
  test "part2" do
    input = AdventOfCode.Input.get!(11, 2016)
    result = part2(input)

    assert result == 55
  end
end
