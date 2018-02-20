defmodule Day17Test do
  use ExUnit.Case
  doctest Day17

  test "calculates door states" do
    assert Day17.options("hijkl") == [ true, true, true, false ]
  end

  test "calculates moves" do
    assert Day17.moves(0, 0, [ true, true, true, true ]) == [ ["D",0,1], ["R",1,0] ]
    assert Day17.moves(0, 0, [ true, false, true, true ]) == [ ["R",1,0] ]
  end

  test "follow paths" do
    assert Day17.make_move(0,0, "hijkl") == [ ["D",0,1 ] ]
    assert Day17.make_move(0,0, "hijklDU") == [ ["R",1,0] ]
    assert Day17.make_move(1,0, "hijklDUR") == []
    assert Day17.make_move(0,0, "ihgpwlah") == [ ["D",0,1],["R",1,0] ]
  end

  test "finds shortest path" do
    assert Day17.shortest_path_fast("ihgpwlah") == "DDRRRD"
  end
  
  test "finds shortest path using all paths" do
    assert Day17.shortest_path("ihgpwlah") == "DDRRRD"
  end
                                       
  test "finds longest path using all paths" do
    assert String.length(Day17.longest_path("ihgpwlah")) == 370
    assert String.length(Day17.longest_path("kglvqrro")) == 492
    assert String.length(Day17.longest_path("ulqzkmiv")) == 830
    
  end
end
