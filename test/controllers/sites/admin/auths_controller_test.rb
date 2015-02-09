require 'test_helper'

class Sites::Admin::AuthsControllerTest < ActionController::TestCase
  setup do
    @sites_admin_auth = sites_admin_auths(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites_admin_auths)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sites_admin_auth" do
    assert_difference('Sites::Admin::Auth.count') do
      post :create, sites_admin_auth: {  }
    end

    assert_redirected_to sites_admin_auth_path(assigns(:sites_admin_auth))
  end

  test "should show sites_admin_auth" do
    get :show, id: @sites_admin_auth
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sites_admin_auth
    assert_response :success
  end

  test "should update sites_admin_auth" do
    patch :update, id: @sites_admin_auth, sites_admin_auth: {  }
    assert_redirected_to sites_admin_auth_path(assigns(:sites_admin_auth))
  end

  test "should destroy sites_admin_auth" do
    assert_difference('Sites::Admin::Auth.count', -1) do
      delete :destroy, id: @sites_admin_auth
    end

    assert_redirected_to sites_admin_auths_path
  end
end
