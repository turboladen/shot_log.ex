defmodule ShotLog.Repo.Migrations.CreateCamera do
  use Ecto.Migration

  def change do
    create table(:cameras, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :model, :string
      add :sub_model, :string
      add :brand_id, references(:brands, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:cameras, [:brand_id])

  end
end
