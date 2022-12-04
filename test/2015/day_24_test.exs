defmodule AdventOfCode.Y2015.Day24Test do
  use ExUnit.Case

  import AdventOfCode.Y2015.Day24

  test "part1" do
    input = AdventOfCode.Input.get!(24, 2015)
    result = part1(input)

    assert result == 11_266_889_531
  end

  test "part2" do
    input = AdventOfCode.Input.get!(24, 2015)
    result = part2(input)

    assert result == 77_387_711
  end
end
