defmodule AdventOfCode.Y2022.Day20Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day20

  test "part1" do
    input = AdventOfCode.Input.get!(20, 2022)
    result = part1(input)

    assert result == 14888
  end

  test "part2" do
    input = AdventOfCode.Input.get!(20, 2022)
    result = part2(input)

    assert result == 3_760_092_545_849
  end
end
