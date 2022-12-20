defmodule AdventOfCode.Y2022.Day19 do
  defp prepare_input(args) do
    args
    |> String.split(
      [
        "Blueprint ",
        ": Each ore robot costs ",
        " ore. Each clay robot costs ",
        " ore. Each obsidian robot costs ",
        " ore and ",
        " clay. Each geode robot costs ",
        " ore and ",
        " obsidian.",
        "\n"
      ],
      trim: true
    )
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(7)
    |> Enum.map(fn values ->
      %{
        id: Enum.at(values, 0),
        ore: %{ore: Enum.at(values, 1)},
        clay: %{ore: Enum.at(values, 2)},
        obsidian: %{ore: Enum.at(values, 3), clay: Enum.at(values, 4)},
        geode: %{ore: Enum.at(values, 5), obsidian: Enum.at(values, 6)}
      }
    end)
  end

  defp increase_inventory(robots, inventory) do
    Map.merge(robots, inventory, fn _, a, b -> a + b end)
  end

  defp can_build?(blueprint, inventory, robot_type) do
    new_inventory =
      blueprint |> Map.get(robot_type) |> Map.merge(inventory, fn _, a, b -> b - a end)

    if Enum.all?(new_inventory, fn {_, v} -> v >= 0 end) do
      {robot_type, new_inventory}
    else
      :no
    end
  end

  defp options_to_build(inventory, blueprint) do
    buildable =
      [
        can_build?(blueprint, inventory, :geode),
        can_build?(blueprint, inventory, :obsidian),
        can_build?(blueprint, inventory, :clay),
        can_build?(blueprint, inventory, :ore)
      ]
      |> Enum.reject(&match?(:no, &1))

    buildable ++ [{nil, inventory}]
  end

  defp increment_robots(robots, nil), do: robots

  defp increment_robots(robots, robot_type),
    do: Map.update(robots, robot_type, 1, fn a -> a + 1 end)

  defp simulate(_, _, inventory, 33, _) do
    inventory
  end

  defp simulate(%{id: id} = blueprint, robots, inventory, minute, cache) do
    options =
      inventory
      |> options_to_build(blueprint)
      |> Enum.map(fn {robot_type, inventory} ->
        inventory = increase_inventory(robots, inventory)
        robots = increment_robots(robots, robot_type)

        {robots, inventory}
      end)

    # Compute heuristic and update best value for the current minute:
    # geode robots * 1000 + obsidian robots
    best =
      case :ets.lookup(cache, {id, minute}) do
        [{_, v}] -> v
        _ -> 0
      end

    new_best =
      options
      |> Enum.map(fn {%{obsidian: obsidian, geode: geode}, _} -> geode * 1000 + obsidian end)
      |> Enum.max()

    best =
      if new_best > best do
        :ets.insert(cache, {{id, minute}, new_best})
        new_best
      else
        best
      end

    options
    # Filter out nodes that can't beat our heuristic - 1 (allowing an extra obsidian robot)
    |> Enum.filter(fn {%{obsidian: obsidian, geode: geode}, _} ->
      geode * 1000 + obsidian >= best - 1
    end)
    |> Enum.map(fn {robots, inventory} ->
      simulate(blueprint, robots, inventory, minute + 1, cache)
    end)
    |> Enum.max_by(fn %{geode: geode} -> geode end, fn -> %{geode: 0} end)
  end

  def part1(args) do
    cache = :ets.new(:store, [:set, :public])

    args
    |> prepare_input()
    |> Enum.map(fn %{id: id} = blueprint ->
      inventory =
        simulate(
          blueprint,
          %{ore: 1, clay: 0, obsidian: 0, geode: 0},
          %{ore: 0, clay: 0, obsidian: 0, geode: 0},
          1,
          cache
        )

      id * inventory.geode
    end)
    |> Enum.sum()
  end

  def part2(args) do
    cache = :ets.new(:store, [:set, :public])

    args
    |> prepare_input()
    |> Enum.take(3)
    |> Enum.map(fn blueprint ->
      inventory =
        simulate(
          blueprint,
          %{ore: 1, clay: 0, obsidian: 0, geode: 0},
          %{ore: 0, clay: 0, obsidian: 0, geode: 0},
          1,
          cache
        )

      inventory.geode
    end)
    |> Enum.product()
  end
end
