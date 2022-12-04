defmodule AdventOfCode.Y2015.Day22 do
  @spells [:missile, :drain, :shield, :poison, :recharge]

  def part1(args) do
    boss = {_boss_hp, _boss_atk, _boss_status} = args
    you = {_hp, _mana, _status, _spent} = {50, 500, [], 0}

    1..10000
    |> Enum.map(fn _ ->
      try do
        turn_p1({boss, you, []})
      catch
        e -> e
      end
    end)
    |> Enum.filter(fn {k, _} -> k == :win end)
    |> Enum.min_by(fn {_, {_, {_, _, _, s}, _}} -> s end)
    |> then(fn {_, {_, {_, _, _, s}, _}} -> s end)
  end

  defp turn_p1(state) do
    state
    |> tick_statuses()
    |> check_end()
    |> cast_spell()
    |> check_end()
    |> tick_statuses()
    |> check_end()
    |> boss_atk()
    |> check_end()
    |> turn_p1()
  end

  def part2(args) do
    boss = {_boss_hp, _boss_atk, _boss_status} = args
    you = {_hp, _mana, _status, _spent} = {50, 500, [], 0}

    1..100_000
    |> Enum.map(fn _ ->
      try do
        turn_p2({boss, you, []})
      catch
        e -> e
      end
    end)
    |> Enum.filter(fn {k, _} -> k == :win end)
    |> Enum.min_by(fn {_, {_, {_, _, _, s}, _}} -> s end)
  end

  defp turn_p2(state) do
    state
    |> hard_mode()
    |> tick_statuses()
    |> check_end()
    |> cast_spell()
    |> check_end()
    |> tick_statuses()
    |> check_end()
    |> boss_atk()
    |> check_end()
    |> turn_p2()
  end

  defp hard_mode({{boss_hp, boss_atk, boss_status}, {hp, mana, status, spent}, acts}) do
    {{boss_hp, boss_atk, boss_status}, {hp - 1, mana, status, spent}, acts}
  end

  defp tick_statuses({{boss_hp, boss_atk, boss_status}, {hp, mana, status, spent}, acts}) do
    boss_hp =
      boss_status
      |> Enum.reduce(boss_hp, fn {:poison, _}, acc -> acc - 3 end)

    mana =
      Enum.reduce(status, mana, fn
        {:recharge, _}, acc -> acc + 101
        _, acc -> acc
      end)

    {
      {boss_hp, boss_atk, reduce_status_counters(boss_status)},
      {hp, mana, reduce_status_counters(status), spent},
      acts
    }
  end

  defp reduce_status_counters(status) do
    status
    |> Enum.map(fn {k, v} -> {k, v - 1} end)
    |> Enum.filter(fn {_, v} -> v > 0 end)
    |> Enum.into(%{})
  end

  defp cast_spell(r = {boss = {boss_hp, boss_atk, boss_status}, {hp, mana, status, spent}, acts}) do
    spells = @spells
    spells = if mana < 53, do: List.delete(spells, :missile), else: spells
    spells = if mana < 73, do: List.delete(spells, :drain), else: spells

    spells =
      if Map.has_key?(boss_status, :poison) or mana < 173,
        do: List.delete(spells, :poison),
        else: spells

    spells =
      if Map.has_key?(status, :recharge) or mana < 229,
        do: List.delete(spells, :recharge),
        else: spells

    spells =
      if Map.has_key?(status, :shield) or mana < 113,
        do: List.delete(spells, :shield),
        else: spells

    if length(spells) == 0, do: throw({:lose, r})

    spell = Enum.random(spells)
    acts = acts ++ [spell]

    case spell do
      :missile ->
        {{boss_hp - 4, boss_atk, boss_status}, {hp, mana - 53, status, spent + 53}, acts}

      :drain ->
        {{boss_hp - 2, boss_atk, boss_status}, {hp + 2, mana - 73, status, spent + 73}, acts}

      :shield ->
        {boss, {hp, mana - 113, Map.put(status, :shield, 6), spent + 113}, acts}

      :poison ->
        {{boss_hp, boss_atk, Map.put(boss_status, :poison, 6)},
         {hp, mana - 173, status, spent + 173}, acts}

      :recharge ->
        {boss, {hp, mana - 229, Map.put(status, :recharge, 5), spent + 229}, acts}
    end
  end

  defp boss_atk({boss = {_, boss_atk, _}, {hp, mana, status = %{:shield => _}, spent}, acts}) do
    hp = hp - max(boss_atk - 7, 1)
    {boss, {hp, mana, status, spent}, acts}
  end

  defp boss_atk({boss = {_, boss_atk, _}, {hp, mana, status, spent}, acts}) do
    hp = hp - boss_atk
    {boss, {hp, mana, status, spent}, acts}
  end

  defp check_end(r = {{boss_hp, _, _}, {hp, _, _, _}, _}) do
    cond do
      boss_hp <= 0 -> throw({:win, r})
      hp <= 0 -> throw({:lose, r})
      true -> r
    end
  end
end
