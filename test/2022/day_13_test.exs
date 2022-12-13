defmodule AdventOfCode.Y2022.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day13

  test "part1" do
    input = AdventOfCode.Input.get!(13, 2022)
    result = part1(input)

    assert result == 5825
  end

  test "part2" do
    input = AdventOfCode.Input.get!(13, 2022)
    result = part2(input)

    assert result == 24477
  end
end
