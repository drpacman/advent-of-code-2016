defmodule Day12Test do
  use ExUnit.Case
  doctest Day12

  @example [ { :cpy, 41, :a }, { :inc, :a}, { :inc, :a }, { :dec, :a }, { :jnz, :a, 2 }, { :dec, :a }]

  @machine %{ pc: 0, a: 1, b: 2, c: 3, d: 4 }
  
  test "interprets copy instructions correctly" do
    assert Day12.execute({ :cpy, 41, :a }, @machine) == %{ pc: 1, a: 41, b: 2, c: 3, d: 4 }
    assert Day12.execute({ :cpy, :c, :a }, @machine) == %{ pc: 1, a: 3, b: 2, c: 3, d: 4 }
  end

  test "interprets inc instructions correctly" do
     assert Day12.execute({ :inc, :d }, @machine) == %{ pc: 1, a: 1, b: 2, c: 3, d: 5 }
  end

  test "interprets dec instructions correctly" do
     assert Day12.execute({ :dec, :d }, @machine) == %{ pc: 1, a: 1, b: 2, c: 3, d: 3 }
  end

  test "interprets jnz instructions correctly" do
     assert Day12.execute({ :jnz, :a, 2 }, @machine) == %{ pc: 2, a: 1, b: 2, c: 3, d: 4 }
     assert Day12.execute({ :jnz, :a, 2 }, %{ pc: 0, a: 0, b: 2, c: 3, d: 4}) == %{ pc: 1, a: 0, b: 2, c: 3, d: 4 }
     assert Day12.execute({ :jnz, 1, 2 }, %{ pc: 0, a: 0, b: 2, c: 3, d: 4}) == %{ pc: 2, a: 0, b: 2, c: 3, d: 4 }
  end

  test "processes list of instructions" do
    output = Day12.process(@example, %{ pc: 0, a: 0, b: 0, c: 0, d: 0})
    assert Map.get(output, :a) == 42
  end

  test "reads and processes file" do
    output = Day12.read("resources/example.txt") |> Day12.process(%{ pc: 0, a: 0, b: 0, c: 0, d: 0})
    assert Map.get(output, :a) == 42
  end
end
