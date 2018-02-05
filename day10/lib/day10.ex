defmodule Day10 do
  @moduledoc """
  Documentation for Day10.
  """

  def handle_message(state) do
    receive do
      { :value, value } ->
        cond do
          Keyword.get(state, :value) == nil ->
            if Keyword.get(state, :type) == "output" do
              send Keyword.get(state, :parent), { :output, Keyword.get(state, :number), value}
            else
              handle_message(Keyword.put(state, :value, value))
            end
          Keyword.has_key?(state, :low_pid) == false ->
            send self(), { :value, value }
            handle_message(state)
          true ->
            [ low, high ] = Enum.sort([ Keyword.get(state, :value), value ])
            send Keyword.get(state, :parent), { :sent, Keyword.get(state, :number), low, high }
            send Keyword.get(state, :low_pid), { :value, low}
            send Keyword.get(state, :high_pid), { :value, high}
            handle_message( Keyword.delete(state, :value) )
        end
      { :target, low_pid_target, high_pid_target } ->
        handle_message( Keyword.put(state, :low_pid, low_pid_target) |> Keyword.put(:high_pid, high_pid_target))
    end    
  end

  def lookup(world, name) do
    if Map.has_key?(world, name) do
      { world, Map.get(world, name) }
    else
      case Regex.run(~r/(.*) (\d+)/, name) do
        [ _, type, n ] ->
          parent = self()
          target = spawn(fn -> handle_message([name: name, parent: parent, type: type, number: String.to_integer(n)]) end)
          { Map.put(world, name, target), target }
      end
    end
  end

  def send_target_message(world, target, message) do
    { new_world, target } = lookup(world, target)
     send target, message
     new_world
  end
  
  def process_instruction(world, instruction) do
    case Regex.run(~r/^value (\d+) goes to (.*)$/, instruction) do
      [ _, value, target ] ->
        send_target_message(world, target, {:value, String.to_integer(value)})
      _ -> case Regex.run(~r/^(.*) gives low to (.*) and high to (.*)$/, instruction) do
             [ _, target, low_target, high_target ] ->
               { w1, low } = lookup(world, low_target)
               { w2, high } = lookup(w1, high_target)
               send_target_message(w2, target, { :target, low, high })
           end
    end
  end

  def process_instructions(instrs) do
    Enum.reduce instrs, %{}, fn(instr, world)-> process_instruction(world, instr) end
  end

  def read_input(filename) do
    File.read!(filename) |> String.trim() |> String.split("\n")
  end

  def process_file(filename) do
    read_input(filename)
    |> process_instructions
  end

  def part1(low, high) do
    receive do
      { :sent, n, ^low, ^high } ->
        IO.puts "Part 1 answer is bot number #{n}"
      x ->
        part1(low, high)
    end
  end

  def part2(outputs, size) do
    receive do
      { :output, n, value } when n < size ->
        updated_outputs = put_elem(outputs, n, value)
        result = Tuple.to_list(updated_outputs) |> Enum.reduce(1,fn(x, acc)-> acc*x end)
        if result != 0 do
          IO.puts "Part 2 answer is #{Integer.to_string(result)}"
        else
          part2(updated_outputs, size)
        end
      _ ->
        part2(outputs, size)
    end
  end

  def main(_args) do
    process_file("resources/input.txt")
    part1(17, 61)
    process_file("resources/input.txt")
    part2({0,0,0}, 3)
  end
                       
end
