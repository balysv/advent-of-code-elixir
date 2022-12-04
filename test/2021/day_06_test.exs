defmodule AdventOfCode.Y2021.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day06

  test "part1" do
    # input = "3,4,3,1,2"

    input = AdventOfCode.Input.get!(6, 2021)
    result = part1(input)

    assert result == 351188
  end

  test "part2" do
    # input = "3,4,3,1,2"

    input = AdventOfCode.Input.get!(6, 2021)
    result = part2(input)

    assert result == 1595779846729
  end
end
