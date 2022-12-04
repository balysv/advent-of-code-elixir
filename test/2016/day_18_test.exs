defmodule AdventOfCode.Y2016.Day18Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day18

  test "part1" do
    input = AdventOfCode.Input.get!(18, 2016)
    result = part1(input)

    assert result == 1978
  end

  test "part2" do
    input = AdventOfCode.Input.get!(18, 2016)
    result = part2(input)

    assert result == 20_003_246
  end
end
