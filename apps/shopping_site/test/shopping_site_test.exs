defmodule ShoppingSiteTest do
  use ExUnit.Case
  doctest ShoppingSite

  test "greets the world" do
    assert ShoppingSite.hello() == :world
  end
end
