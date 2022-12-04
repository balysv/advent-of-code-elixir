defmodule AdventOfCode.Y2015.Day25Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day25

  test "part1" do
    input = {2981, 3075}
    result = part1(input)

    assert result == 1
  end
end
