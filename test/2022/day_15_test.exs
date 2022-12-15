defmodule AdventOfCode.Y2022.Day15Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day15

  @tag timeout: :infinity
  test "part1" do
    input = AdventOfCode.Input.get!(15, 2022)
    result = part1(input)

    assert result == 5_403_290
  end

  @tag timeout: :infinity
  test "part2" do
    input = AdventOfCode.Input.get!(15, 2022)
    result = part2(input)

    assert result == 10_291_582_906_626
  end
end
