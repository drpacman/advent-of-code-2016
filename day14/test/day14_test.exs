defmodule Day14Test do
  use ExUnit.Case
  doctest Day14

  test "finds a triple" do
    case Day14.find_a_triple("abc", 18, &Day14.encode/2) do
      { "8", _ } -> assert true
    end
  end

  test "finds a matching five" do
    case Day14.find_a_matching_five("abc", 816, "e", &Day14.encode/2) do
      { true, _ } -> assert true
    end
    case Day14.find_a_matching_five("abc", 815, "e", &Day14.encode/2) do
      { false, _ } -> assert true
    end
    case Day14.find_a_matching_five("abc", 200, "9", &Day14.encode/2) do
      { true, _ } -> assert true
    end
  end

  test "finds keys" do
    assert Day14.find_keys("abc", 0, 2, &Day14.encode/2) == [ 39, 92 ]
    assert Enum.at(Day14.find_keys("abc", 0, 65, &Day14.encode/2), 64) == 22728
  end

  test "calculates stretch key" do
    assert Day14.stretch_encode("abc", 0) == "a107ff634856bb300138cac6568c0f24"
  end

  test "finds keys for stretch" do
    assert Day14.find_keys("abc", 0, 1, &Day14.stretch_encode/2) == [ 10 ]
  end

  @tag timeout: 300000
  test "finds keys for stretch (full)" do
      assert Enum.at(Day14.find_keys("abc", 0, 65, &Day14.stretch_encode/2), 64) == 22551
  end
end
