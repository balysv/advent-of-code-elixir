defmodule AdventOfCode.Y2022.Day21Test do
  use ExUnit.Case

  import AdventOfCode.Y2022.Day21

  test "part1" do
    input = AdventOfCode.Input.get!(21, 2022)
    result = part1(input)

    assert result == 268_597_611_536_314
  end

  test "part2" do
    input = AdventOfCode.Input.get!(21, 2022)
    result = part2(input)

    assert result == 3_451_534_022_347
  end
end
