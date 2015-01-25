require 'test_helper'

class Sites::OrganizationPostListsControllerTest < ActionController::TestCase
  setup do
    @sites_organization_post_list = sites_organization_post_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites_organization_post_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sites_organization_post_list" do
    assert_difference('Sites::OrganizationPostList.count') do
      post :create, sites_organization_post_list: {  }
    end

    assert_redirected_to sites_organization_post_list_path(assigns(:sites_organization_post_list))
  end

  test "should show sites_organization_post_list" do
    get :show, id: @sites_organization_post_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sites_organization_post_list
    assert_response :success
  end

  test "should update sites_organization_post_list" do
    patch :update, id: @sites_organization_post_list, sites_organization_post_list: {  }
    assert_redirected_to sites_organization_post_list_path(assigns(:sites_organization_post_list))
  end

  test "should destroy sites_organization_post_list" do
    assert_difference('Sites::OrganizationPostList.count', -1) do
      delete :destroy, id: @sites_organization_post_list
    end

    assert_redirected_to sites_organization_post_lists_path
  end
end
