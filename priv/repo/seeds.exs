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

  def find_or_create_brand(name) do
    query = from c in Brand,
            where: c.name == ^name

    Repo.one(query) || Repo.insert!(%Brand{name: name})
  end
end

["Minolta", "Nikon", "Olympus"]
|> Enum.each(fn(name) -> ShotLog.Seeder.find_or_create_brand(name) end)
