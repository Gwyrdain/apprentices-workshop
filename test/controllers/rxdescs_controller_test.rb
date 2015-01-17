require 'test_helper'

class RxdescsControllerTest < ActionController::TestCase
  setup do
    @rxdesc = rxdescs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rxdescs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rxdesc" do
    assert_difference('Rxdesc.count') do
      post :create, rxdesc: { description: @rxdesc.description, keywords: @rxdesc.keywords, room_id: @rxdesc.room_id }
    end

    assert_redirected_to rxdesc_path(assigns(:rxdesc))
  end

  test "should show rxdesc" do
    get :show, id: @rxdesc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rxdesc
    assert_response :success
  end

  test "should update rxdesc" do
    patch :update, id: @rxdesc, rxdesc: { description: @rxdesc.description, keywords: @rxdesc.keywords, room_id: @rxdesc.room_id }
    assert_redirected_to rxdesc_path(assigns(:rxdesc))
  end

  test "should destroy rxdesc" do
    assert_difference('Rxdesc.count', -1) do
      delete :destroy, id: @rxdesc
    end

    assert_redirected_to rxdescs_path
  end
end
