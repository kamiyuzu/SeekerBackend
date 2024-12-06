defmodule AndroidDummy.Assets.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assets" do
    field :set, :string
    field :username, :string
    field :latitude, :string
    field :longitude, :string
    field :name, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:latitude, :longitude, :set, :username, :name, :description])
    |> validate_required([:latitude, :longitude, :set, :username, :name, :description])
  end
end
