require 'test_helper'

class Admin::OrganizationAuthorizationsControllerTest < ActionController::TestCase
  setup do
    @admin_organization_authorization = admin_organization_authorizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_organization_authorizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_organization_authorization" do
    assert_difference('Admin::OrganizationAuthorization.count') do
      post :create, admin_organization_authorization: {  }
    end

    assert_redirected_to admin_organization_authorization_path(assigns(:admin_organization_authorization))
  end

  test "should show admin_organization_authorization" do
    get :show, id: @admin_organization_authorization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_organization_authorization
    assert_response :success
  end

  test "should update admin_organization_authorization" do
    patch :update, id: @admin_organization_authorization, admin_organization_authorization: {  }
    assert_redirected_to admin_organization_authorization_path(assigns(:admin_organization_authorization))
  end

  test "should destroy admin_organization_authorization" do
    assert_difference('Admin::OrganizationAuthorization.count', -1) do
      delete :destroy, id: @admin_organization_authorization
    end

    assert_redirected_to admin_organization_authorizations_path
  end
end
