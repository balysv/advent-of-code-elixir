defmodule AdventOfCode.Y2021.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day13

  test "part1" do
    input = """
    6,10
    0,14
    9,10
    0,3
    10,4
    4,11
    6,0
    6,12
    4,1
    0,13
    10,12
    3,4
    3,0
    8,4
    1,10
    2,14
    8,10
    9,0

    fold along y=7
    fold along x=5
    """
#    input = AdventOfCode.Input.get!(13, 2021)
    result = part1(input)

    assert result == 17
  end

  @tag :skip
  test "part2" do
    input = """
    6,10
    0,14
    9,10
    0,3
    10,4
    4,11
    6,0
    6,12
    4,1
    0,13
    10,12
    3,4
    3,0
    8,4
    1,10
    2,14
    8,10
    9,0

    fold along y=7
    fold along x=5
    """
    # input = AdventOfCode.Input.get!(13, 2021)
    result = part2(input)

    assert result
  end
end
