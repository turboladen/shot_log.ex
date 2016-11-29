defmodule ShotLog.Camera do
  use ShotLog.Web, :model

  schema "cameras" do
    field :model, :string
    field :sub_model, :string
    belongs_to :brand, ShotLog.Brand

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:model, :sub_model, :brand_id])
    |> validate_required([:model, :brand_id])
    |> foreign_key_constraint(:brand_id)
  end
end
