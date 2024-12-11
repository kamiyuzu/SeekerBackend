defmodule AndroidDummyWeb.AssetController do
  use AndroidDummyWeb, :controller

  alias AndroidDummy.Assets
  alias AndroidDummy.Assets.Asset

  action_fallback AndroidDummyWeb.FallbackController

  def index(conn, %{"username" => username}) do
    assets = Assets.list_assets(username)
    render(conn, :index, assets: assets)
  end

  def create(conn, asset_params) do
    asset_params =
      asset_params
      |> Map.put("name", Faker.Cat.name())
      |> Map.put("description", "This asset was located at latitude: " <> asset_params["latitude"] <> ", longitude: " <> asset_params["longitude"] <> ".\n" <> Faker.Lorem.paragraph(1..3))

    case Assets.get_asset_if_exist(asset_params) do
      nil ->
        with {:ok, %Asset{} = asset} <- Assets.create_asset(asset_params) do
          conn
          |> put_status(:created)
          |> render(:show, asset: asset)
        end
      asset ->
        conn
          |> put_status(:created)
          |> render(:show, asset: asset)
    end
  end

  def show(conn, %{"id" => id}) do
    asset = Assets.get_asset!(id)
    render(conn, :show, asset: asset)
  end

  def update(conn, %{"id" => id} = asset_params) do
    asset = Assets.get_asset!(id)

    with {:ok, %Asset{} = asset} <- Assets.update_asset(asset, asset_params) do
      render(conn, :show, asset: asset)
    end
  end

  def delete(conn, %{"id" => id}) do
    asset = Assets.get_asset!(id)

    with {:ok, %Asset{}} <- Assets.delete_asset(asset) do
      send_resp(conn, :no_content, "")
    end
  end
end
