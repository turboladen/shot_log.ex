defmodule ShotLog.Brand do
  use ShotLog.Web, :model

  schema "brands" do
    field :name, :string

    has_many :cameras, ShotLog.Camera

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def names do
    brand_query = from b in ShotLog.Brand,
                  select: {b.name, b.id}

    ShotLog.Repo.all(brand_query)
  end
end
