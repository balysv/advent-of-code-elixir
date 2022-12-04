defmodule AdventOfCode.Y2021.Day15Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day15

  test "part1" do
    input = """
    1163751742
    1381373672
    2136511328
    3694931569
    7463417111
    1319128137
    1359912421
    3125421639
    1293138521
    2311944581
    """

    # input = AdventOfCode.Input.get!(15, 2021)
    result = part1(input)

    assert result == 40
  end

  test "part2" do
    input = """
    1163751742
    1381373672
    2136511328
    3694931569
    7463417111
    1319128137
    1359912421
    3125421639
    1293138521
    2311944581
    """

    # input = AdventOfCode.Input.get!(15, 2021)
    result = part2(input)

    assert result == 315
  end
end
