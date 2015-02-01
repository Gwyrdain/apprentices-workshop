require 'test_helper'

class MobilesControllerTest < ActionController::TestCase
  setup do
    @mobile = mobiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mobiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mobile" do
    assert_difference('Mobile.count') do
      post :create, mobile: { act_flags: @mobile.act_flags, affect_flags: @mobile.affect_flags, alignment: @mobile.alignment, area_id: @mobile.area_id, keywords: @mobile.keywords, lang_spoken: @mobile.lang_spoken, langs_known: @mobile.langs_known, ldesc: @mobile.ldesc, level: @mobile.level, look_desc: @mobile.look_desc, sdesc: @mobile.sdesc, sex: @mobile.sex, vnum: @mobile.vnum }
    end

    assert_redirected_to mobile_path(assigns(:mobile))
  end

  test "should show mobile" do
    get :show, id: @mobile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mobile
    assert_response :success
  end

  test "should update mobile" do
    patch :update, id: @mobile, mobile: { act_flags: @mobile.act_flags, affect_flags: @mobile.affect_flags, alignment: @mobile.alignment, area_id: @mobile.area_id, keywords: @mobile.keywords, lang_spoken: @mobile.lang_spoken, langs_known: @mobile.langs_known, ldesc: @mobile.ldesc, level: @mobile.level, look_desc: @mobile.look_desc, sdesc: @mobile.sdesc, sex: @mobile.sex, vnum: @mobile.vnum }
    assert_redirected_to mobile_path(assigns(:mobile))
  end

  test "should destroy mobile" do
    assert_difference('Mobile.count', -1) do
      delete :destroy, id: @mobile
    end

    assert_redirected_to mobiles_path
  end
end
