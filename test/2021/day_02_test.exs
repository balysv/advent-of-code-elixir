defmodule AdventOfCode.Y2021.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day02

  test "part1" do
    input = "forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2"

    # input = AdventOfCode.Input.get!(2, 2021)

    result = part1(input)

    assert result == 150
  end

  test "part2" do
    input = "forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2"

    # input = AdventOfCode.Input.get!(2, 2021)

    result = part2(input)

    assert result == 900
  end
end
