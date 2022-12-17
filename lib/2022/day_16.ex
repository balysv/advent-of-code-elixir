defmodule AdventOfCode.Y2022.Day16 do
  defp prepare_input(args) do
    grid =
      args
      |> String.split(
        [
          "Valve ",
          " has flow rate=",
          "; tunnel leads to valve ",
          "; tunnels lead to valves ",
          "\n"
        ],
        trim: true
      )
      |> Enum.chunk_every(3)
      |> Enum.map(fn [valve, flow_rate, targets] ->
        flow_rate = String.to_integer(flow_rate)
        targets = String.split(targets, ", ", trim: true)

        {valve, targets, flow_rate}
      end)

    graph =
      Enum.reduce(
        grid,
        Graph.new(vertex_identifier: & &1),
        fn {valve, targets, _}, graph ->
          targets
          |> Enum.map(&Graph.Edge.new(valve, &1, weight: 1))
          |> then(&Graph.add_edges(graph, &1))
        end
      )

    flow_rates =
      grid
      |> Enum.map(fn {valve, _, flow_rate} -> {valve, flow_rate} end)
      |> Enum.filter(&Kernel.>(elem(&1, 1), 0))

    # compute path lengths between each valves that have flow rates > 0
    # and solve the graph for each possible path
    grid =
      for {valve_a, _rate_a} = a <- [{"AA", 0} | flow_rates],
          {valve_b, rate_b} = b <- flow_rates,
          a != b do
        {valve_a, {valve_b, length(Graph.get_shortest_path(graph, valve_a, valve_b)), rate_b}}
      end
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    grid
  end

  defp destinations(grid, valve, seen, timer) do
    grid
    |> Map.get(valve)
    |> Enum.filter(fn {dest, cost, _} -> dest not in seen and timer - cost >= 0 end)
    |> Enum.map(fn {dest, cost, flow} -> {dest, cost, (timer - cost) * flow} end)
  end

  defp solve(grid, valve, seen, pressure, timer, human?) do
    case destinations(grid, valve, seen, timer) do
      [] ->
        if human? do
          [pressure]
        else
          # elephant solved - now solve for human (you)
          solve(grid, "AA", seen, pressure, 26, true)
        end

      dests ->
        Enum.flat_map(dests, fn {dest, cost, flows} ->
          solve(grid, dest, [dest | seen], pressure + flows, timer - cost, human?)
        end)
    end
  end

  def part1(args) do
    args
    |> prepare_input()
    |> solve("AA", [], 0, 30, true)
    |> Enum.max()
  end

  def part2(args) do
    args
    |> prepare_input()
    |> solve("AA", [], 0, 26, false)
    |> Enum.max()
  end
end
