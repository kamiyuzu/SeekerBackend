defmodule AndroidDummy.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets) do
      add :latitude, :string
      add :longitude, :string
      add :set, :string
      add :username, :string
      add :name, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:assets, [:username, :latitude, :longitude, :set], name: :unique_asset_idx)
  end
end
