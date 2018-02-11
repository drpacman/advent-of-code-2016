defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

  @structure %{ floor: 0, floors: [MapSet.new([ { :h, :m }, {:l, :m} ]), MapSet.new([ { :h, :g } ]), MapSet.new([ { :l, :g } ]), MapSet.new([])] }

  @invalid_structure %{ floor: 0, floors: [MapSet.new([ { :h, :m }, {:l, :m} ]), MapSet.new([ { :h, :g }, { :l, :m }]), MapSet.new([ { :l, :g } ]), MapSet.new([])] }

  test "validate structure" do
    assert Day11.is_valid(@structure)
    assert Day11.is_valid(@invalid_structure) == false
  end

  test "valid options from a floor include any two generators" do
    options = Day11.get_options( MapSet.new([{ :h, :m }, { :l, :g }, { :h, :g }]) )
    assert Enum.any? options, &(&1 ==  MapSet.new([{:l, :g}, {:h, :g}]))
  end

  test "valid options from a floor with single item is the single item" do
    options = Day11.get_options( MapSet.new([{ :h, :m }]) )
    assert Enum.any? options, &(&1 ==  MapSet.new([{:h, :m}]))
  end

  test "no valid options from a floor with no items" do
    options = Day11.get_options( MapSet.new([]) )
    assert options == []
  end

  test "is finished if only first 3 floors are empty" do
    assert Day11.is_finished %{ floor: 0, floors: [MapSet.new([]),MapSet.new([]),MapSet.new([]), MapSet.new([ { :h, :m }, {:l, :m}, {:h,:g},{:l,:g} ])] }
    assert Day11.is_finished(@structure) == false
  end

  test "valid options are ones from the current floor" do
    assert Enum.count(Day11.get_moves(@structure)) == 1
    assert Enum.count(Day11.get_moves(@structure)) == 1
  end

  #test "test process of example" do
  #  assert Day11.process([@structure]) == 11
  #end   

  test "test process of finished with new entries on bottom floor" do
    part_start = %{floor: 3, floors: [MapSet.new([{:el, :g}, {:el, :m}, {:di, :g}, {:di, :m}]), MapSet.new([]), MapSet.new([]), MapSet.new([{ :co, :g }, { :co, :m} ])]}
    assert Day11.process([part_start]) == 24
  end   
end
