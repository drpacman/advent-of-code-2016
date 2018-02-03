defmodule Day7 do
  def is_valid_part1(code) do
    case Regex.run(~r/(\w)(?!\1)(\w)\2\1/, code) do
      [ _, a, b ] ->
        IO.puts "part1 #{code} - because of #{a}#{b}#{b}#{a}"
        case Regex.run(~r/\[[^\]]*(\w)(?!\1)(\w)\2\1[^\]]*\]/, code) do
          [ _, c, d] ->
            IO.puts "failing #{code}, because of #{c}#{d}#{d}#{c}"
            false
          _ ->
            true
         end
      _ ->
        false
    end
  end
  
  def is_valid_part2(code) do
    Enum.filter(Regex.scan(~r/(\w)(?!\1)(\w)\1[^\]]*\[?/, code), fn([_, a, b]) ->
        { _, r } = Regex.compile(~s"#{b}#{a}#{b}[^\\[]*\\]")
        IO.inspect r
        Regex.match?( r, code)
    end) |> Enum.any?
  end

  def read_input(filename) do
    File.read!(filename) |> String.trim() |> String.split("\n")
  end

  def validate_file_part1(filename) do
    validate_file(filename, &is_valid_part1/1)
  end

  def validate_file_part2(filename) do
    validate_file(filename, &is_valid_part2/1)
  end

  def validate_file(filename, is_valid) do
    read_input(filename) |> Enum.filter(&(is_valid.(&1))) |> Enum.count()
  end

  def main(_args) do
    part1 = validate_file_part1("resources/input.txt")
    IO.puts "Part1 #{part1}"
    part2 = validate_file_part2("resources/input.txt")
    IO.puts "Part2 #{part2}"
  end
end
