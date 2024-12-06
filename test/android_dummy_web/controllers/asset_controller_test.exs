defmodule AndroidDummyWeb.AssetControllerTest do
  use AndroidDummyWeb.ConnCase

  import AndroidDummy.AssetsFixtures

  alias AndroidDummy.Assets.Asset

  @create_attrs %{
    set: "some set",
    username: "some username",
    latitude: "some latitude",
    longitude: "some longitude"
  }
  @update_attrs %{
    set: "some updated set",
    username: "some updated username",
    latitude: "some updated latitude",
    longitude: "some updated longitude"
  }
  @invalid_attrs %{set: nil, username: nil, latitude: nil, longitude: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all assets", %{conn: conn} do
      conn = get(conn, ~p"/api/assets")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create asset" do
    test "renders asset when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/assets", asset: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/assets/#{id}")

      assert %{
               "id" => ^id,
               "latitude" => "some latitude",
               "longitude" => "some longitude",
               "set" => "some set",
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/assets", asset: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update asset" do
    setup [:create_asset]

    test "renders asset when data is valid", %{conn: conn, asset: %Asset{id: id} = asset} do
      conn = put(conn, ~p"/api/assets/#{asset}", asset: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/assets/#{id}")

      assert %{
               "id" => ^id,
               "latitude" => "some updated latitude",
               "longitude" => "some updated longitude",
               "set" => "some updated set",
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, asset: asset} do
      conn = put(conn, ~p"/api/assets/#{asset}", asset: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete asset" do
    setup [:create_asset]

    test "deletes chosen asset", %{conn: conn, asset: asset} do
      conn = delete(conn, ~p"/api/assets/#{asset}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/assets/#{asset}")
      end
    end
  end

  defp create_asset(_) do
    asset = asset_fixture()
    %{asset: asset}
  end
end
