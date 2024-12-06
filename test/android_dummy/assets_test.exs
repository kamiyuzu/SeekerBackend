defmodule AndroidDummy.AssetsTest do
  use AndroidDummy.DataCase

  alias AndroidDummy.Assets

  describe "assets" do
    alias AndroidDummy.Assets.Asset

    import AndroidDummy.AssetsFixtures

    @invalid_attrs %{set: nil, username: nil, latitude: nil, longitude: nil}

    test "list_assets/0 returns all assets" do
      asset = asset_fixture()
      assert Assets.list_assets() == [asset]
    end

    test "get_asset!/1 returns the asset with given id" do
      asset = asset_fixture()
      assert Assets.get_asset!(asset.id) == asset
    end

    test "create_asset/1 with valid data creates a asset" do
      valid_attrs = %{set: "some set", username: "some username", latitude: "some latitude", longitude: "some longitude"}

      assert {:ok, %Asset{} = asset} = Assets.create_asset(valid_attrs)
      assert asset.set == "some set"
      assert asset.username == "some username"
      assert asset.latitude == "some latitude"
      assert asset.longitude == "some longitude"
    end

    test "create_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assets.create_asset(@invalid_attrs)
    end

    test "update_asset/2 with valid data updates the asset" do
      asset = asset_fixture()
      update_attrs = %{set: "some updated set", username: "some updated username", latitude: "some updated latitude", longitude: "some updated longitude"}

      assert {:ok, %Asset{} = asset} = Assets.update_asset(asset, update_attrs)
      assert asset.set == "some updated set"
      assert asset.username == "some updated username"
      assert asset.latitude == "some updated latitude"
      assert asset.longitude == "some updated longitude"
    end

    test "update_asset/2 with invalid data returns error changeset" do
      asset = asset_fixture()
      assert {:error, %Ecto.Changeset{}} = Assets.update_asset(asset, @invalid_attrs)
      assert asset == Assets.get_asset!(asset.id)
    end

    test "delete_asset/1 deletes the asset" do
      asset = asset_fixture()
      assert {:ok, %Asset{}} = Assets.delete_asset(asset)
      assert_raise Ecto.NoResultsError, fn -> Assets.get_asset!(asset.id) end
    end

    test "change_asset/1 returns a asset changeset" do
      asset = asset_fixture()
      assert %Ecto.Changeset{} = Assets.change_asset(asset)
    end
  end
end
