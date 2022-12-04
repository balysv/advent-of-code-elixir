defmodule AdventOfCode.Y2015.Day14 do
  # Vixen can fly 19 km/s for 7 seconds, but then must rest for 124 seconds.

  @end_time 2503

  defp prepare_input(raw) do
    raw
    |> String.split(
      ["\n", " can fly ", " km/s for ", " seconds, but then must rest for ", " seconds."],
      trim: true
    )
    |> Enum.chunk_every(4, 4)
    |> Enum.map(fn [name, speed, fly_time, rest_time] ->
      {name,
       {String.to_integer(speed), String.to_integer(fly_time), String.to_integer(rest_time)}}
    end)
    |> Enum.into(%{})
  end

  def part1(args) do
    args
    |> prepare_input()
    |> Enum.map(fn
      {name, {speed, fly_time, rest_time}} ->
        full_cycles = div(@end_time, fly_time + rest_time)
        remaining = min(rem(@end_time, fly_time + rest_time), fly_time)
        dist = speed * (full_cycles * fly_time) + remaining * speed
        {name, dist}
    end)
    |> Enum.max_by(&elem(&1, 1))
  end

  def part2(args) do
    reindeer = args |> prepare_input()

    scores =
      reindeer
      |> Enum.map(fn {name, {_, _, _}} -> {name, {0, 0}} end)
      |> Enum.into(%{})

    0..@end_time
    |> Enum.reduce(scores, fn
      time, acc ->
        distances =
          acc
          |> Enum.map(fn {name, {dist, score}} ->
            {speed, fly_time, rest_time} = Map.get(reindeer, name)
            time_in_cycle = rem(time, fly_time + rest_time)
            to_add = if time_in_cycle < fly_time, do: speed, else: 0
            {name, dist + to_add, score}
          end)
          |> Enum.sort_by(&elem(&1, 1), :desc)

        winning_distance = hd(distances) |> elem(1)

        distances
        |> Enum.map(fn
          {name, dist, score} when dist == winning_distance -> {name, {dist, score + 1}}
          {name, dist, score} -> {name, {dist, score}}
        end)
        |> Enum.into(%{})
    end)
    |> Enum.max_by(fn {_, {_, score}} -> score end)
  end
end
