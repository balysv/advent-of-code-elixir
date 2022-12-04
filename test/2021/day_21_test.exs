defmodule AdventOfCode.Y2021.Day21Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day21

  test "part1" do
    input = """
    Player 1 starting position: 4
    Player 2 starting position: 8
    """

    # input  = AdventOfCode.Input.get!(21, 2021)
    result = part1(input)

    assert result == 739_785
  end

  test "part2" do
    input = """
    Player 1 starting position: 4
    Player 2 starting position: 8
    """

    # input  = AdventOfCode.Input.get!(21, 2021)
    result = part2(input)

    assert result == 444_356_092_776_315
  end
end
