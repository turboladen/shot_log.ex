# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ShotLog.Repo.insert!(%ShotLog.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule ShotLog.Seeder do
  import Ecto.Query

  alias ShotLog.Repo
  alias ShotLog.Brand
  alias ShotLog.Camera

  # TODO: Switch to use Repo.insert_or_update
  def find_or_create_brand(name) do
    query = from b in Brand,
            where: b.name == ^name

    Repo.one(query) || Repo.insert!(%Brand{name: name})
  end

  def find_or_create_camera(model, sub_model, brand_name) do
    brand = Repo.get_by(Brand, name: brand_name)

    query = from c in Camera,
            where: c.model == ^model and
                   c.brand_id == ^brand.id

    if sub_model do
      query = from c in query,
              where: c.sub_model == ^sub_model
    end

    Repo.one(query) ||
    Repo.insert!(%Camera{model: model, sub_model: sub_model, brand_id: brand.id})
  end
end

# Create brands
["Minolta", "Nikon", "Olympus"]
|> Enum.each(fn(name) -> ShotLog.Seeder.find_or_create_brand(name) end)

# Create cameras
[
  %{brand: "Minolta", model: "SR-T 101",  sub_model: nil},
  %{brand: "Olympus", model: "OM-1",      sub_model: "n"},
  %{brand: "Nikon",   model: "FE",        sub_model: nil}
 ]
|> Enum.each(fn(camera) -> ShotLog.Seeder.find_or_create_camera(camera.model, camera.sub_model, camera.brand) end)
