defmodule TexterTest do
  use ExUnit.Case
  doctest Texter

  test "greets the world" do
    assert Texter.hello() == :world
  end
end
