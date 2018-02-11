defmodule Day11 do
  @moduledoc """
  Documentation for Day11.
  """

  def has_dangerous_generator(entries, chip_elem) do
     Enum.any? entries, fn({el, type}) -> (el != chip_elem) && (type == :g) end
  end

  def is_valid_combination(entries) do
    chips = Enum.filter entries, fn({el, type})-> type == :m end
    Enum.all? chips, fn({el, type}) ->
      Enum.any? entries, fn(entry)->
         entry == {el, :g} || has_dangerous_generator(entries, el) == false
      end
    end
  end

  def is_valid(structure) do
    Enum.all? Map.get(structure, :floors), fn(floor)->
      is_valid_combination(floor)
    end
  end

  def get_options(floor) do
    floor_as_list = MapSet.to_list(floor)
    len = Enum.count floor_as_list
    # generate all combos
    candidates = cond do
      len >= 2 ->
        Enum.reduce 0..len-2, [], fn(first, acc) ->
          Enum.concat(acc, Enum.reduce(first+1..len-1, [], fn(second, acc) ->
                acc ++ [ MapSet.new([ Enum.at(floor_as_list, first), Enum.at(floor_as_list, second) ]),
                  MapSet.new([ Enum.at(floor_as_list, first) ]),
                  MapSet.new([ Enum.at(floor_as_list, second) ]) ]
          end))
        end
      len == 1 ->
        [ MapSet.new(floor) ]
      len == 0 ->
        []
    end
    Enum.filter candidates, &(is_valid_combination(&1))
  end

  def is_finished(structure) do
    Enum.all? 0..2, &(Enum.at(Map.get(structure, :floors), &1) == MapSet.new([]))
  end

  def get_moves(structure) do
    floors = Map.get(structure, :floors)
    current_floor = Enum.at(floors, Map.get(structure, :floor))
    options = get_options(current_floor)
    current_floor_num = Map.get(structure, :floor)
    target_floor_nums = cond do
      current_floor_num == 0 ->
        [ 1 ]
      current_floor_num == 3 ->
        [ 2 ]
      true ->
        [ current_floor_num + 1, current_floor_num - 1 ]
    end

    candidates = Enum.reduce(target_floor_nums, [], fn(target_floor_num, acc1) ->
      acc1 ++ Enum.reduce options, [], fn(option, acc2) ->
        updated_floors = update_floors_with_option(floors, current_floor_num, target_floor_num, option)
        acc2 ++ [ %{ floor: target_floor_num, floors: updated_floors } ]
      end
    end)

    Enum.filter candidates, &(is_valid(&1))
  end

  def update_floors_with_option(floors, src, dest, option) do
     Enum.map 0..3, fn(floor_num) ->
      cond do
        floor_num == src ->
          MapSet.difference( MapSet.new(Enum.at(floors, floor_num)), option )
        floor_num == dest ->
          MapSet.union( option, MapSet.new(Enum.at(floors, floor_num)) ) 
        true ->
          Enum.at(floors, floor_num)
      end
    end
  end

  def process(structures, history \\ MapSet.new(), steps \\ 0) do
    finished = Enum.find structures, &(is_finished &1)
    if finished != nil do
      IO.puts "Steps #{Integer.to_string steps}"
      IO.inspect finished
      steps
    else 
      next_structures = Enum.reduce(structures, [], fn(s, acc)-> acc ++ get_moves(s) end)
      new_structures = MapSet.difference(MapSet.new(next_structures), history)
      if MapSet.size(new_structures) > 0 do
        #IO.puts "Step #{Integer.to_string steps} identified #{Enum.count new_structures} next steps"
        process(new_structures, MapSet.union(new_structures, history), steps+1)
      else
        IO.puts "Failed search - after #{steps}"
        -1
      end
    end
  end

  def main(_args) do
    part1 = process([%{
                        floor: 0,
                        floors: [
                          MapSet.new([{:pr,:g}, {:pr, :m}]),
                          MapSet.new([{ :co, :g }, { :cu, :g}, { :ru, :g }, { :pl, :g }]),
                          MapSet.new([{:co, :m}, {:cu, :m}, {:ru, :m}, {:pl, :m} ]),
                          MapSet.new([])
                        ]
                     }
                    ])
    IO.puts "Part1 num steps is #{Integer.to_string part1}"
    IO.puts "We can calculate part 2 as a sum of part 1 + shortest steps to recover from starting on 3rd floor with a pair and the 4 new items on the ground floor"
    part2_start = process([%{
                              floor: 3,
                              floors: [
                                MapSet.new([{:el, :g}, {:el, :m}, {:di, :g}, {:di, :m}]),
                                MapSet.new([]),
                                MapSet.new([]),
                                MapSet.new([{ :co, :g }, { :co, :m} ])
                              ]
                           }
                          ])
    part2 = part1 + part2_start
    IO.puts "Part2 num steps is #{Integer.to_string part2}"
  end
end
