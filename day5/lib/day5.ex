defmodule Day5 do
  @moduledoc """
  Documentation for Day5.
  """

  def calculate_value_part1(base, n) do
    calculate_value(base, n, &( { true, String.downcase(Enum.at(&1,5)) }))
  end

  def calculate_value_part2(base, n, max) do
    calculate_value(base, n, fn(cs)->
      case Regex.run(~r/(\d)/, Enum.at(cs,5)) do
        [ _, x ] ->
          xint = String.to_integer x
          if xint < max do
            { true, xint, String.downcase(Enum.at(cs,6)) }
          else
            { false, nil }
          end
        _ ->
          { false, nil }
      end
    end)
  end

  def calculate_value(base, n, handle) do
    key = base <> Integer.to_string(n)
    hash = :crypto.hash(:md5, key) |> Base.encode16
    cs = String.codepoints(hash)
    case Enum.take cs, 5 do
      [ "0", "0", "0", "0", "0" ] ->
        handle.(cs)
      _ ->
        { false, nil }
    end
  end

  def calculate_code_part1(base, depth, index \\ 0, result \\ "") do
    if depth == 0 do
      result
    else
      case calculate_value_part1(base, index) do
        { true, code } ->
          calculate_code_part1(base, depth-1, index+1, result <> code)
        _ ->
          calculate_code_part1(base, depth, index+1, result)
      end
    end
  end

  def update_code(curr, pos, code) do
    if (pos > 0) do
      String.slice(curr, 0..pos-1) <> code <> String.slice(curr, pos+1..-1)
    else
      code <> String.slice(curr, 1..-1)
    end
  end
  
  def calculate_code_part2(base, depth) do
    calculate_code_part2(base, depth, depth, 0, String.duplicate("_", depth))
  end

  def calculate_code_part2(base, max, depth, index, result) do
    if depth == 0 do
      result
    else
      case calculate_value_part2(base, index, max) do
        { true, pos, code } ->
          if String.at(result, pos) == "_" do
            IO.puts result
            calculate_code_part2(base, max, depth-1, index+1, update_code(result, pos, code))
          else
            calculate_code_part2(base, max, depth, index+1, result)
          end
        _ ->
          calculate_code_part2(base, max, depth, index+1, result)
      end
    end
  end

  def main(_args) do
    part1 = calculate_code_part1("reyedfim", 8)
    IO.puts "Part 1 code is #{part1}"
    part2 = calculate_code_part2("reyedfim", 8)
    IO.puts "Part 2 code is #{part2}"
  end
end
