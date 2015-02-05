require 'test_helper'

class AreaStringsControllerTest < ActionController::TestCase
  setup do
    @area_string = area_strings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:area_strings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create area_string" do
    assert_difference('AreaString.count') do
      post :create, area_string: { area_id: @area_string.area_id, message_to_pc: @area_string.message_to_pc, message_to_room: @area_string.message_to_room, vnum: @area_string.vnum }
    end

    assert_redirected_to area_string_path(assigns(:area_string))
  end

  test "should show area_string" do
    get :show, id: @area_string
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @area_string
    assert_response :success
  end

  test "should update area_string" do
    patch :update, id: @area_string, area_string: { area_id: @area_string.area_id, message_to_pc: @area_string.message_to_pc, message_to_room: @area_string.message_to_room, vnum: @area_string.vnum }
    assert_redirected_to area_string_path(assigns(:area_string))
  end

  test "should destroy area_string" do
    assert_difference('AreaString.count', -1) do
      delete :destroy, id: @area_string
    end

    assert_redirected_to area_strings_path
  end
end
