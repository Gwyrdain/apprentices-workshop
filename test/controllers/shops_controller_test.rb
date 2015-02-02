require 'test_helper'

class ShopsControllerTest < ActionController::TestCase
  setup do
    @shop = shops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop" do
    assert_difference('Shop.count') do
      post :create, shop: { buy_type_1: @shop.buy_type_1, buy_type_2: @shop.buy_type_2, buy_type_3: @shop.buy_type_3, buy_type_4: @shop.buy_type_4, buy_type_5: @shop.buy_type_5, close_hour: @shop.close_hour, mobile_id: @shop.mobile_id, open_hour: @shop.open_hour, race: @shop.race }
    end

    assert_redirected_to shop_path(assigns(:shop))
  end

  test "should show shop" do
    get :show, id: @shop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop
    assert_response :success
  end

  test "should update shop" do
    patch :update, id: @shop, shop: { buy_type_1: @shop.buy_type_1, buy_type_2: @shop.buy_type_2, buy_type_3: @shop.buy_type_3, buy_type_4: @shop.buy_type_4, buy_type_5: @shop.buy_type_5, close_hour: @shop.close_hour, mobile_id: @shop.mobile_id, open_hour: @shop.open_hour, race: @shop.race }
    assert_redirected_to shop_path(assigns(:shop))
  end

  test "should destroy shop" do
    assert_difference('Shop.count', -1) do
      delete :destroy, id: @shop
    end

    assert_redirected_to shops_path
  end
end
