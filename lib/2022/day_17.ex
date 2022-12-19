defmodule AdventOfCode.Y2022.Day17 do
  @line_h [String.graphemes("..@@@@.")]
  @cross ["...@...", "..@@@..", "...@..."] |> Enum.map(&String.graphemes/1)
  @el ["....@..", "....@..", "..@@@.."] |> Enum.map(&String.graphemes/1)
  @line_v ["..@....", "..@....", "..@....", "..@...."] |> Enum.map(&String.graphemes/1)
  @square ["..@@...", "..@@..."] |> Enum.map(&String.graphemes/1)

  @empty String.graphemes(".......")
  @ops [{"@@@@.", ".@@@@"}, {"@@@.", ".@@@"}, {"@@.", ".@@"}, {"@.", ".@"}]

  defp add_shape(grid, shape) do
    shape ++ [@empty, @empty, @empty] ++ grid
  end

  defp solidify_grid(grid) do
    grid
    |> Enum.reject(fn line -> line == @empty end)
    |> Enum.map(fn line ->
      Enum.map(line, fn
        "@" -> "#"
        s -> s
      end)
    end)
  end

  defp move_shape(grid, gust) do
    Enum.map(grid, fn line ->
      if "@" in line do
        @ops
        |> Enum.reduce_while(Enum.join(line), fn {a, b}, line ->
          new_line =
            if gust == ">",
              do: String.replace(line, a, b),
              else: String.replace(line, b, a)

          if line == new_line do
            {:cont, line}
          else
            {:halt, String.graphemes(new_line)}
          end
        end)
      else
        line
      end
    end)
  end

  defp gust_shape(grid, gust) do
    check = if gust == "<", do: ".@", else: "@."

    can_move? =
      grid
      |> Enum.filter(fn line -> "@" in line end)
      |> Enum.map(&Enum.join/1)
      |> Enum.all?(&String.contains?(&1, check))

    if can_move? do
      grid = move_shape(grid, gust)
      grid
    else
      grid
    end
  end

  defp down_shape(grid) do
    transposed = Enum.zip_with(grid, & &1)

    can_move? =
      transposed
      |> Enum.filter(fn line -> "@" in line end)
      |> Enum.map(&Enum.join/1)
      |> Enum.all?(&String.contains?(&1, "@."))

    if can_move? do
      transposed |> move_shape(">") |> Enum.zip_with(& &1)
    else
      :collission
    end
  end

  defp simulate(grid, turn, flows) do
    gust = Enum.at(flows, turn)
    grid = gust_shape(grid, gust)

    case down_shape(grid) do
      :collission ->
        {solidify_grid(grid), turn + 1}

      grid ->
        simulate(grid, turn + 1, flows)
    end
  end

  def part1(args) do
    jets = args |> String.trim() |> String.graphemes() |> Stream.cycle()
    shapes = [@line_h, @cross, @el, @line_v, @square] |> Stream.cycle() |> Stream.with_index()

    grid =
      shapes
      |> Enum.reduce_while({[], 0}, fn
        {_, 2022}, {grid, _} ->
          {:halt, grid}

        {shape, _idx}, {grid, turn} ->
          {grid, turn} =
            grid
            |> add_shape(shape)
            |> simulate(turn, jets)

          {:cont, {grid, turn}}
      end)

    length(grid)
  end

  def part2(args) do
    jets = args |> String.trim() |> String.graphemes() |> Stream.cycle()

    [@line_h, @cross, @el, @line_v, @square]
    |> Stream.cycle()
    |> Stream.with_index()
    |> Enum.reduce_while({[], 0, %{}}, fn
      # catch sub-loop
      {_, 1900}, {grid, _, _} ->
        throw({"Grid length for subloop", length(grid)})
        {:halt, grid}

      {shape, idx}, {grid, turn, prev} ->
        {grid, turn} =
          grid
          |> add_shape(shape)
          |> simulate(turn, jets)

        snapshot = grid |> Enum.take(100)

        case Map.get(prev, snapshot, []) do
          [one, two] ->
            throw({"Double loop detected", {one, two}})

          _ ->
            nil
        end

        prev =
          Map.update(prev, snapshot, [{idx, length(grid)}], fn c ->
            [{idx, length(grid)} | c]
          end)

        {:cont, {grid, turn, prev}}
    end)

    # Simulation run until the same grid pattern repeated twice. Results:
    # cycle length of 2654, starting at rock 720 having 1103 height
    # reminder height of sub-loop 1080 = (2947 - 1103)
    588_235_293 * 2654 + 1103 + (2947 - 1103)
  end
end
