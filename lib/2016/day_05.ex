defmodule AdventOfCode.Y2016.Day05 do
  def part1(args) do
    good_hashes(args)
    |> Enum.take(8)
    |> Enum.map(&Enum.at(&1, 5))
    |> Enum.join()
  end

  def part2(args) do
    good_hashes(args)
    |> Enum.reduce_while(List.duplicate("_", 8), fn hash, password ->
      password = process_hash(hash, password)
      if filled?(password), do: {:halt, password}, else: {:cont, password}
    end)
    |> Enum.join()
  end

  defp filled?(password), do: Enum.all?(password, fn s -> s != "_" end)

  defp process_hash(hash, password) do
    case Enum.at(hash, 5) |> Integer.parse() do
      :error ->
        password

      {idx, _} ->
        if Enum.at(password, idx) == "_" do
          password = List.replace_at(password, idx, Enum.at(hash, 6))
          IO.puts("Decrypted: #{Enum.join(password)}")
          password
        else
          password
        end
    end
  end

  defp good_hashes(input) do
    1..100_000_000_000
    |> Stream.map(fn d -> :crypto.hash(:md5, input <> "#{d}") |> Base.encode16() end)
    |> Stream.filter(&String.starts_with?(&1, "00000"))
    |> Stream.map(fn s -> String.downcase(s) |> String.graphemes() end)
  end
end
