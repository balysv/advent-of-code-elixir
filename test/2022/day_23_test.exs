defmodule AdventOfCode.Y2022.Day23Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day23

  test "part1" do
    input = AdventOfCode.Input.get!(23, 2022)

    result = part1(input)

    assert result == 4005
  end

  @tag timeout: :infinity
  test "part2" do
    input = AdventOfCode.Input.get!(23, 2022)
    result = part2(input)

    assert result == 1008
  end
end
