defmodule AdventOfCode.Y2021.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day09

  test "part1" do
    input = """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """

    # input = AdventOfCode.Input.get!(9, 2021)
    result = part1(input)

    assert result == 15
  end

  test "part2" do
    input = """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """

    # input = AdventOfCode.Input.get!(9, 2021)
    result = part2(input)

    assert result == 1134
  end

  @tag :skip
  @tag timeout: :infinity
  test "big_boy" do
    {:ok, input} = File.read("test/advent_of_code/day_09_big_boy.in")

    Benchee.run(%{
      "big_boy_p1" => fn ->
        part1(input) |> IO.puts()
      end,
      "big_boy_p2" => fn ->
        part2(input) |> IO.puts()
      end
    })
  end
end
