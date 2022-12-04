defmodule AdventOfCode.Y2021.Day16 do
  defmodule Parser do
    @unterminated -1

    def parse(bits), do: parse_packets(bits, []) |> hd()

    # Counting packets reached 0
    defp parse_packets(bits, packets, 0), do: {packets, bits}

    #  Discard fewer than 8 bits
    defp parse_packets(bits, packets, _) when byte_size(bits) < 8, do: packets

    defp parse_packets(bits, packets, packet_count \\ @unterminated) do
      {packet, rem_bits} = parse_header(bits) |> parse_packet()
      parse_packets(rem_bits, packets ++ [packet], packet_count - 1)
    end

    defp parse_header(<<version::bytes-size(3)>> <> <<type_id::bytes-size(3)>> <> rest) do
      {%{version: String.to_integer(version, 2), type_id: String.to_integer(type_id, 2)}, rest}
    end

    defp parse_packet({header = %{type_id: 4}, bits}) do
      {value, rem_bits} = parse_literal_value(bits, "")
      packet = Map.put(header, :value, value)
      {packet, rem_bits}
    end

    defp parse_packet({header, bits}) do
      {sub_packets, rem_bits} = parse_operator_header(bits) |> parse_subpackets()
      packet = Map.put(header, :packets, sub_packets)
      {packet, rem_bits}
    end

    defp parse_literal_value("0" <> <<value::bytes-size(4)>> <> rem_bits, acc) do
      {String.to_integer(acc <> value, 2), rem_bits}
    end

    defp parse_literal_value("1" <> <<value::bytes-size(4)>> <> rem_bits, acc) do
      parse_literal_value(rem_bits, acc <> value)
    end

    defp parse_operator_header("0" <> <<value::bytes-size(15)>> <> rem_bits) do
      {[bit_count: String.to_integer(value, 2)], rem_bits}
    end

    defp parse_operator_header("1" <> <<value::bytes-size(11)>> <> rem_bits) do
      {[packet_count: String.to_integer(value, 2)], rem_bits}
    end

    defp parse_subpackets({[bit_count: bit_count], bits}) do
      {subpacket_bits, rem_bits} = String.split_at(bits, bit_count)
      sub_packets = parse_packets(subpacket_bits, [])
      {sub_packets, rem_bits}
    end

    defp parse_subpackets({[packet_count: packet_count], bits}) do
      parse_packets(bits, [], packet_count)
    end
  end

  defmodule Versions do
    def sum(packet), do: do_sum(packet)

    defp do_sum(%{packets: packets, version: version}) do
      packet_sum = packets |> Enum.map(&do_sum/1) |> Enum.sum()
      version + packet_sum
    end

    defp do_sum(%{version: version}), do: version
  end

  defmodule Interpretor do
    def interpret(packet), do: do_interpret(packet)

    defp do_interpret(%{type_id: 0, packets: packets}) do
      packets |> Enum.map(&do_interpret/1) |> Enum.sum()
    end

    defp do_interpret(%{type_id: 1, packets: packets}) do
      packets |> Enum.map(&do_interpret/1) |> Enum.product()
    end

    defp do_interpret(%{type_id: 2, packets: packets}) do
      packets |> Enum.map(&do_interpret/1) |> Enum.min()
    end

    defp do_interpret(%{type_id: 3, packets: packets}) do
      packets |> Enum.map(&do_interpret/1) |> Enum.max()
    end

    defp do_interpret(%{type_id: 4, value: value}), do: value

    defp do_interpret(%{type_id: 5, packets: [packet1, packet2]}) do
      if do_interpret(packet1) > do_interpret(packet2), do: 1, else: 0
    end

    defp do_interpret(%{type_id: 6, packets: [packet1, packet2]}) do
      if do_interpret(packet1) < do_interpret(packet2), do: 1, else: 0
    end

    defp do_interpret(%{type_id: 7, packets: [packet1, packet2]}) do
      if do_interpret(packet1) == do_interpret(packet2), do: 1, else: 0
    end
  end

  defp prepare_input(raw_input) do
    raw_input
    |> String.replace("\n", "")
    |> Base.decode16!()
    |> to_base2_string
  end

  def to_base2_string(binary) do
    for(<<x::size(1) <- binary>>, do: "#{x}")
    |> Enum.join("")
  end

  def part1(args), do: prepare_input(args) |> Parser.parse() |> Versions.sum()

  def part2(args), do: prepare_input(args) |> Parser.parse() |> Interpretor.interpret()
end
