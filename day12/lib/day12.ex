defmodule Day12 do
  @moduledoc """
  Documentation for Day12.
  """

  def execute(instr, machine) do
    case instr do
      { :cpy, value, reg } when is_integer value ->
        Map.put(machine, reg, value) |> Map.update!(:pc, &(&1+1))
      { :cpy, src, dest } ->
        Map.put(machine, dest, Map.get(machine, src)) |> Map.update!(:pc, &(&1+1))
      { :inc, reg } ->
        Map.update!(machine, reg, &(&1+1)) |> Map.update!(:pc, &(&1+1))
      { :dec, reg } ->
        Map.update!(machine, reg, &(&1-1)) |> Map.update!(:pc, &(&1+1))
      { :jnz, 1, n } ->
          Map.update!(machine, :pc, &(&1+n))
      { :jnz, reg, n } ->
        if Map.get(machine, reg) > 0 do
          Map.update!(machine, :pc, &(&1+n))
        else
          Map.update!(machine, :pc, &(&1+1))
        end
    end  
  end

  def parse(instr) do
    case Regex.run(~r/cpy (-?\d+) ([a-d])/, instr) do
      [ _, number, reg ] ->
        { :cpy, String.to_integer(number), String.to_atom(reg) }
      _ ->
        case Regex.run(~r/cpy (.*) ([a-d])/, instr) do
          [ _, src, dest ] ->
            { :cpy, String.to_atom(src), String.to_atom(dest) }
          _ ->
            case Regex.run(~r/(inc|dec) ([a-d])/, instr) do
              [ _, cmd, reg ] ->
                { String.to_atom(cmd), String.to_atom(reg) }
              _ ->
                case Regex.run(~r/jnz (.*) (-?\d+)/, instr) do
                  [ _, "1", value ] ->
                    { :jnz, 1, String.to_integer(value) }
                  [ _, reg, value ] ->
                    { :jnz, String.to_atom(reg), String.to_integer(value) }
                end
            end
        end
    end
  end                       
             
  def process(instructions, machine) do
    instr = Enum.at(instructions, Map.get(machine, :pc), nil)
    if is_nil instr do
      machine
    else
      process(instructions, execute(instr, machine))
    end
  end

  def read(filename) do
    File.read!(filename) |> String.trim() |> String.split("\n") |> Enum.map(&(parse &1))
  end

  def main(_args) do
    instructions = read("resources/input.txt")
    part1 = process(instructions, %{ pc: 0, a: 0, b: 0, c: 0, d: 0})
    IO.puts "Part1, reg a has value #{Map.get(part1, :a)}"
    part2 = process(instructions, %{ pc: 0, a: 0, b: 0, c: 1, d: 0})
    IO.puts "Part2, reg a has value #{Map.get(part2, :a)}"
  end
end
