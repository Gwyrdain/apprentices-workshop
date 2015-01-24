require 'test_helper'

class ObjsControllerTest < ActionController::TestCase
  setup do
    @obj = objs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:objs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create obj" do
    assert_difference('Obj.count') do
      post :create, obj: { area_id: @obj.area_id, cost: @obj.cost, extra_flags: @obj.extra_flags, keywords: @obj.keywords, ldesc: @obj.ldesc, misc_flags: @obj.misc_flags, sdesc: @obj.sdesc, type: @obj.type, v0: @obj.v0, v1: @obj.v1, v2: @obj.v2, v3: @obj.v3, vnum: @obj.vnum, wear_flags: @obj.wear_flags, weight: @obj.weight }
    end

    assert_redirected_to obj_path(assigns(:obj))
  end

  test "should show obj" do
    get :show, id: @obj
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @obj
    assert_response :success
  end

  test "should update obj" do
    patch :update, id: @obj, obj: { area_id: @obj.area_id, cost: @obj.cost, extra_flags: @obj.extra_flags, keywords: @obj.keywords, ldesc: @obj.ldesc, misc_flags: @obj.misc_flags, sdesc: @obj.sdesc, type: @obj.type, v0: @obj.v0, v1: @obj.v1, v2: @obj.v2, v3: @obj.v3, vnum: @obj.vnum, wear_flags: @obj.wear_flags, weight: @obj.weight }
    assert_redirected_to obj_path(assigns(:obj))
  end

  test "should destroy obj" do
    assert_difference('Obj.count', -1) do
      delete :destroy, id: @obj
    end

    assert_redirected_to objs_path
  end
end
