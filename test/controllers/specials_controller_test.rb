require 'test_helper'

class SpecialsControllerTest < ActionController::TestCase
  setup do
    @special = specials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:specials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create special" do
    assert_difference('Special.count') do
      post :create, special: { extended_value_1: @special.extended_value_1, extended_value_2: @special.extended_value_2, extended_value_3: @special.extended_value_3, extended_value_4: @special.extended_value_4, extended_value_5: @special.extended_value_5, mobile_id: @special.mobile_id, name: @special.name, special_type: @special.special_type }
    end

    assert_redirected_to special_path(assigns(:special))
  end

  test "should show special" do
    get :show, id: @special
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @special
    assert_response :success
  end

  test "should update special" do
    patch :update, id: @special, special: { extended_value_1: @special.extended_value_1, extended_value_2: @special.extended_value_2, extended_value_3: @special.extended_value_3, extended_value_4: @special.extended_value_4, extended_value_5: @special.extended_value_5, mobile_id: @special.mobile_id, name: @special.name, special_type: @special.special_type }
    assert_redirected_to special_path(assigns(:special))
  end

  test "should destroy special" do
    assert_difference('Special.count', -1) do
      delete :destroy, id: @special
    end

    assert_redirected_to specials_path
  end
end
