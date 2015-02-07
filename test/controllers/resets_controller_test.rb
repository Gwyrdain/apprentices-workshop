require 'test_helper'

class ResetsControllerTest < ActionController::TestCase
  setup do
    @reset = resets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reset" do
    assert_difference('Reset.count') do
      post :create, reset: { area_id: @reset.area_id, reset_type: @reset.reset_type, val_1: @reset.val_1, val_2: @reset.val_2, val_3: @reset.val_3, val_4: @reset.val_4 }
    end

    assert_redirected_to reset_path(assigns(:reset))
  end

  test "should show reset" do
    get :show, id: @reset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reset
    assert_response :success
  end

  test "should update reset" do
    patch :update, id: @reset, reset: { area_id: @reset.area_id, reset_type: @reset.reset_type, val_1: @reset.val_1, val_2: @reset.val_2, val_3: @reset.val_3, val_4: @reset.val_4 }
    assert_redirected_to reset_path(assigns(:reset))
  end

  test "should destroy reset" do
    assert_difference('Reset.count', -1) do
      delete :destroy, id: @reset
    end

    assert_redirected_to resets_path
  end
end
