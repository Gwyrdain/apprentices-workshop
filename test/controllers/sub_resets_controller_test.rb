require 'test_helper'

class SubResetsControllerTest < ActionController::TestCase
  setup do
    @sub_reset = sub_resets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_resets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_reset" do
    assert_difference('SubReset.count') do
      post :create, sub_reset: { reset_id: @sub_reset.reset_id, reset_type: @sub_reset.reset_type, val_1: @sub_reset.val_1, val_2: @sub_reset.val_2, val_3: @sub_reset.val_3, val_4: @sub_reset.val_4 }
    end

    assert_redirected_to sub_reset_path(assigns(:sub_reset))
  end

  test "should show sub_reset" do
    get :show, id: @sub_reset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sub_reset
    assert_response :success
  end

  test "should update sub_reset" do
    patch :update, id: @sub_reset, sub_reset: { reset_id: @sub_reset.reset_id, reset_type: @sub_reset.reset_type, val_1: @sub_reset.val_1, val_2: @sub_reset.val_2, val_3: @sub_reset.val_3, val_4: @sub_reset.val_4 }
    assert_redirected_to sub_reset_path(assigns(:sub_reset))
  end

  test "should destroy sub_reset" do
    assert_difference('SubReset.count', -1) do
      delete :destroy, id: @sub_reset
    end

    assert_redirected_to sub_resets_path
  end
end
