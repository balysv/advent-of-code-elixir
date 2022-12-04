defmodule AdventOfCode.Y2021.Day23Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day23

  @tag :skip
  @tag timeout: :infinity
  test "part1" do
    # """
    # #############
    # #...........#
    # ###B#C#B#D###
    #   #A#D#C#A#
    #   #########
    # """

    result =
      part1({[0, 0, 9, 0, 9, 0, 9, 0, 9, 0, 0], [[10, 10], [1, 100], [1, 1000], [1000, 100]]})

    assert result == 1
  end

  @tag :skip
  @tag timeout: :infinity
  test "part2" do
    # """
    # #############
    # #...........#
    # ###B#A#A#D###
    #   #D#C#B#A#
    #   #D#B#A#C#
    #   #B#C#D#C#
    #   #########
    # """

    result =
      part1(
        {[0, 0, 9, 0, 9, 0, 9, 0, 9, 0, 0],
         [[10, 1000, 1000, 10], [1, 100, 10, 100], [1, 10, 1, 1000], [1000, 1, 100, 100]]}
      )

    assert result == 1
  end
end
