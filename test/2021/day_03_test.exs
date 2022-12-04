defmodule AdventOfCode.Y2021.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day03

  test "part1" do
    input = "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
"
    # input = AdventOfCode.Input.get!(3, 2021)
    result = part1(input)

    assert result == 198
  end

  test "part2" do
    input = "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
"
    # input = AdventOfCode.Input.get!(3, 2021)
    result = part2(input)

    assert result == 230
  end
end
