defmodule EctoMaterializedPath.PathTest do
  use ExUnit.Case, async: true

  alias EctoMaterializedPath.Path

  test "passes with empty list" do
    assert Path.cast([]) == {:ok, []}
  end

  test "passes with integer path elements" do
    assert Path.cast([13, 45, 18]) == {:ok, [13, 45, 18]}
  end

  test "passes with binary path elements" do
    assert Path.cast(["a", "nice", "path"]) == {:ok, ["a", "nice", "path"]}
  end

  test "fails with unsupported path elements" do
    assert Path.cast([make_ref()]) == :error
  end

  test "fails with random value" do
    assert Path.cast(4) == :error
  end

  test "fails with mixed path elements" do
    assert Path.cast([13, "str", 45]) == :error
  end
end
