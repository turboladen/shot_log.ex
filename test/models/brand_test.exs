defmodule ShotLog.BrandTest do
  use ShotLog.ModelCase

  alias ShotLog.Brand

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Brand.changeset(%Brand{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Brand.changeset(%Brand{}, @invalid_attrs)
    refute changeset.valid?
  end
end
