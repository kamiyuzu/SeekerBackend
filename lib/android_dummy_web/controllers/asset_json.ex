defmodule AndroidDummyWeb.AssetJSON do
  alias AndroidDummy.Assets.Asset

  @doc """
  Renders a list of assets.
  """
  def index(%{assets: assets}) do
    %{data: for(asset <- assets, do: data(asset))}
  end

  @doc """
  Renders a single asset.
  """
  def show(%{asset: asset}) do
    %{data: data(asset)}
  end

  defp data(%Asset{} = asset) do
    %{
      id: asset.id,
      latitude: asset.latitude,
      longitude: asset.longitude,
      set: asset.set,
      username: asset.username,
      name: asset.name,
      description: asset.description
    }
  end
end
