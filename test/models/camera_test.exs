defmodule ShotLog.CameraTest do
  use ShotLog.ModelCase

  alias ShotLog.Camera

  @valid_attrs %{model: "some content", sub_model: "some content", brand_id: Ecto.UUID.generate}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Camera.changeset(%Camera{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Camera.changeset(%Camera{}, @invalid_attrs)
    refute changeset.valid?
  end
end
