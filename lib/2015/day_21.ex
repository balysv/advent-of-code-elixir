defmodule AdventOfCode.Y2015.Day21 do
  @weapons [
    {8, 4, 0},
    {10, 5, 0},
    {25, 6, 0},
    {40, 7, 0},
    {74, 8, 0}
  ]

  @armors [
    {13, 0, 1},
    {31, 0, 2},
    {53, 0, 3},
    {75, 0, 4},
    {102, 0, 5}
  ]

  @rings [
    {25, 1, 0},
    {50, 2, 0},
    {100, 3, 0},
    {20, 0, 1},
    {40, 0, 2},
    {80, 0, 3}
  ]

  defp boss(input) do
    [_, _, hit_points, _, damage, _, armor] =
      input
      |> String.split(["\n", " "], trim: true)

    [hit_points, damage, armor]
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def part1(args) do
    boss = boss(args)

    # manual
    for dmg <- 4..13,
        arm <- 0..10,
        you = {100, dmg, arm},
        {state, _, _, _} = turn(boss, you, 0),
        state == :win do
      {dmg, arm}
    end
  end

  def part2(args) do
    boss = boss(args)

    # manual
    # 10, 0 == 160; 9, 1 = 162; 8, 2 = 150; 7, 3 = 188; 6, 4 = 146;
    r =
      for dmg <- 4..13,
          arm <- 0..10,
          you = {100, dmg, arm},
          {state, _, _, _} = turn(boss, you, 0),
          state == :loss do
        {dmg, arm}
      end

    Enum.sort(r, :desc)
  end

  defp turn(boss = {boss_hp, boss_dmg, boss_arm}, you = {hp, dmg, arm}, turn) do
    boss_hp = boss_hp - max(dmg - boss_arm, 1)

    if boss_hp <= 0 do
      {:win, turn, boss, you}
    else
      hp = hp - max(boss_dmg - arm, 1)

      if hp <= 0 do
        {:loss, turn, boss, you}
      else
        turn({boss_hp, boss_dmg, boss_arm}, {hp, dmg, arm}, turn + 1)
      end
    end
  end
end
