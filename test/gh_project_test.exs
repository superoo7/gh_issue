defmodule GhProjectTest do
  use ExUnit.Case
  doctest GhProject

  test "greets the world" do
    assert GhProject.hello() == :world
  end
end
