defmodule AdventOfCode.Y2021.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Y2021.Day14

  test "part1" do
    input = """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """

    # input = AdventOfCode.Input.get!(14, 2021)
    result = part1(input)

    assert result == 1588
  end

  test "part2" do
    input = """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """

    # input = AdventOfCode.Input.get!(14, 2021)
    result = part2(input)

    assert result == 2_188_189_693_529
  end

  @tag :skip
  @tag timeout: :infinity
  test "big boy" do
    {:ok, input} = File.read("test/advent_of_code/day_14_bigboy.in")

    Benchee.run(%{
      "big_boy" => fn ->
        bigboy(input)
      end
    })
  end
end
