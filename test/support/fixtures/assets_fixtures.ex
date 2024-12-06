defmodule AndroidDummy.AssetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AndroidDummy.Assets` context.
  """

  @doc """
  Generate a asset.
  """
  def asset_fixture(attrs \\ %{}) do
    {:ok, asset} =
      attrs
      |> Enum.into(%{
        latitude: "some latitude",
        longitude: "some longitude",
        set: "some set",
        username: "some username"
      })
      |> AndroidDummy.Assets.create_asset()

    asset
  end
end
