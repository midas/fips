defmodule FipsTest do
  use ExUnit.Case
  doctest Fips

  test "greets the world" do
    assert Fips.hello() == :world
  end
end
