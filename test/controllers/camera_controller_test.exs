defmodule ShotLog.CameraControllerTest do
  use ShotLog.ConnCase

  alias ShotLog.Camera
  alias ShotLog.Brand
  @valid_attrs %{model: "some content", sub_model: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, camera_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing cameras"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, camera_path(conn, :new)
    assert html_response(conn, 200) =~ "New camera"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    brand = build_brand()
    valid_attrs = Map.put(@valid_attrs, :brand_id, brand.id)

    conn = post conn, camera_path(conn, :create), camera: valid_attrs
    assert redirected_to(conn) == camera_path(conn, :index)
    assert Repo.get_by(Camera, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, camera_path(conn, :create), camera: @invalid_attrs
    assert html_response(conn, 200) =~ "New camera"
  end

  test "shows chosen resource", %{conn: conn} do
    camera = Repo.insert! %Camera{}
    conn = get conn, camera_path(conn, :show, camera)
    assert html_response(conn, 200) =~ "Show camera"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, camera_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    camera = Repo.insert! %Camera{}
    conn = get conn, camera_path(conn, :edit, camera)
    assert html_response(conn, 200) =~ "Edit camera"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    brand = build_brand()
    valid_attrs = Map.put(@valid_attrs, :brand_id, brand.id)

    camera = Repo.insert! %Camera{}
    conn = put conn, camera_path(conn, :update, camera), camera: valid_attrs
    assert redirected_to(conn) == camera_path(conn, :show, camera)
    assert Repo.get_by(Camera, valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    camera = Repo.insert! %Camera{}
    conn = put conn, camera_path(conn, :update, camera), camera: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit camera"
  end

  test "deletes chosen resource", %{conn: conn} do
    camera = Repo.insert! %Camera{}
    conn = delete conn, camera_path(conn, :delete, camera)
    assert redirected_to(conn) == camera_path(conn, :index)
    refute Repo.get(Camera, camera.id)
  end

  defp build_brand do
    brand_changeset = Brand.changeset(%Brand{name: "thing"})

    Repo.insert!(brand_changeset)
  end
end
