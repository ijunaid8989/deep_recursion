defmodule DeepTest do
  use ExUnit.Case
  doctest Deep

  test "greets the world" do
    assert Deep.hello() == :world
  end
end
