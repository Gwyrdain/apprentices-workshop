require 'test_helper'

class RoomSpecialsControllerTest < ActionController::TestCase
  setup do
    @room_special = room_specials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:room_specials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room_special" do
    assert_difference('RoomSpecial.count') do
      post :create, room_special: { extended_value_1: @room_special.extended_value_1, extended_value_2: @room_special.extended_value_2, extended_value_3: @room_special.extended_value_3, extended_value_4: @room_special.extended_value_4, extended_value_5: @room_special.extended_value_5, name: @room_special.name, room_id: @room_special.room_id, room_special_type: @room_special.room_special_type }
    end

    assert_redirected_to room_special_path(assigns(:room_special))
  end

  test "should show room_special" do
    get :show, id: @room_special
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @room_special
    assert_response :success
  end

  test "should update room_special" do
    patch :update, id: @room_special, room_special: { extended_value_1: @room_special.extended_value_1, extended_value_2: @room_special.extended_value_2, extended_value_3: @room_special.extended_value_3, extended_value_4: @room_special.extended_value_4, extended_value_5: @room_special.extended_value_5, name: @room_special.name, room_id: @room_special.room_id, room_special_type: @room_special.room_special_type }
    assert_redirected_to room_special_path(assigns(:room_special))
  end

  test "should destroy room_special" do
    assert_difference('RoomSpecial.count', -1) do
      delete :destroy, id: @room_special
    end

    assert_redirected_to room_specials_path
  end
end
