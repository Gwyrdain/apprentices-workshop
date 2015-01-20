require 'test_helper'

class ExitsControllerTest < ActionController::TestCase
  setup do
    @exit = exits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exit" do
    assert_difference('Exit.count') do
      post :create, exit: { description: @exit.description, direction: @exit.direction, exit_room_id: @exit.exit_room_id, keyvnum: @exit.keyvnum, keywords: @exit.keywords, name: @exit.name, room_id: @exit.room_id, type: @exit.type }
    end

    assert_redirected_to exit_path(assigns(:exit))
  end

  test "should show exit" do
    get :show, id: @exit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exit
    assert_response :success
  end

  test "should update exit" do
    patch :update, id: @exit, exit: { description: @exit.description, direction: @exit.direction, exit_room_id: @exit.exit_room_id, keyvnum: @exit.keyvnum, keywords: @exit.keywords, name: @exit.name, room_id: @exit.room_id, type: @exit.type }
    assert_redirected_to exit_path(assigns(:exit))
  end

  test "should destroy exit" do
    assert_difference('Exit.count', -1) do
      delete :destroy, id: @exit
    end

    assert_redirected_to exits_path
  end
end
