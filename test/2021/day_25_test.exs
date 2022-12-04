defmodule AdventOfCode.Y2021.Day25Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day25

  test "part1" do
    input = """
    v...>>.vv>
    .vv>>.vv..
    >>.>v>...v
    >>v>>.>.v.
    v>v.vv.v..
    >.>>..v...
    .vv..>.>v.
    v.v..>>v.v
    ....v..v.>
    """
    input  = AdventOfCode.Input.get!(25, 2021)
    result = part1(input)

    assert result == 58
  end
end
