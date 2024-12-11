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
    field :tag, :string, default: ""

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:latitude, :longitude, :set, :username, :name, :description])
    |> validate_required([:latitude, :longitude, :set, :username, :name, :description])
    |> unique_constraint(:unique_asset, name: :unique_asset_idx)
  end

  @doc false
  def changeset_patch(asset, attrs) do
    asset
    |> cast(attrs, [:tag])
    |> validate_required([:tag])
    |> unique_constraint(:unique_asset, name: :unique_asset_idx)
  end
end
