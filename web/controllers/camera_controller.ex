defmodule ShotLog.CameraController do
  use ShotLog.Web, :controller

  alias ShotLog.Camera

  def index(conn, _params) do
    cameras = Repo.all(Camera) |> Repo.preload(:brand)
    render(conn, "index.html", cameras: cameras)
  end

  def new(conn, _params) do
    changeset = Camera.changeset(%Camera{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"camera" => camera_params}) do
    changeset = Camera.changeset(%Camera{}, camera_params)

    case Repo.insert(changeset) do
      {:ok, _camera} ->
        conn
        |> put_flash(:info, "Camera created successfully.")
        |> redirect(to: camera_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    camera = Repo.get!(Camera, id)
    render(conn, "show.html", camera: camera)
  end

  def edit(conn, %{"id" => id}) do
    camera = Repo.get!(Camera, id)
    changeset = Camera.changeset(camera)
    render(conn, "edit.html", camera: camera, changeset: changeset)
  end

  def update(conn, %{"id" => id, "camera" => camera_params}) do
    camera = Repo.get!(Camera, id)
    changeset = Camera.changeset(camera, camera_params)

    case Repo.update(changeset) do
      {:ok, camera} ->
        conn
        |> put_flash(:info, "Camera updated successfully.")
        |> redirect(to: camera_path(conn, :show, camera))
      {:error, changeset} ->
        render(conn, "edit.html", camera: camera, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    camera = Repo.get!(Camera, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(camera)

    conn
    |> put_flash(:info, "Camera deleted successfully.")
    |> redirect(to: camera_path(conn, :index))
  end
end
