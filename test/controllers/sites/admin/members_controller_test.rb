require 'test_helper'

class Sites::Admin::MembersControllerTest < ActionController::TestCase
  setup do
    @sites_admin_member = sites_admin_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites_admin_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sites_admin_member" do
    assert_difference('Sites::Admin::Member.count') do
      post :create, sites_admin_member: {  }
    end

    assert_redirected_to sites_admin_member_path(assigns(:sites_admin_member))
  end

  test "should show sites_admin_member" do
    get :show, id: @sites_admin_member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sites_admin_member
    assert_response :success
  end

  test "should update sites_admin_member" do
    patch :update, id: @sites_admin_member, sites_admin_member: {  }
    assert_redirected_to sites_admin_member_path(assigns(:sites_admin_member))
  end

  test "should destroy sites_admin_member" do
    assert_difference('Sites::Admin::Member.count', -1) do
      delete :destroy, id: @sites_admin_member
    end

    assert_redirected_to sites_admin_members_path
  end
end
