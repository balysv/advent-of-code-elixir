defmodule AdventOfCode.Y2016.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Y2016.Day12

  test "part1" do
    input = AdventOfCode.Input.get!(12, 2016)
    result = part1(input)

    assert result == 318_077
  end

  test "part2" do
    input = AdventOfCode.Input.get!(12, 2016)
    result = part2(input)

    assert result == 9_227_731
  end
end
