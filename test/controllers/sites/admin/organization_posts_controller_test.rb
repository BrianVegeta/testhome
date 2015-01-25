require 'test_helper'

class Sites::Admin::OrganizationPostsControllerTest < ActionController::TestCase
  setup do
    @sites_admin_organization_post = sites_admin_organization_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites_admin_organization_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sites_admin_organization_post" do
    assert_difference('Sites::Admin::OrganizationPost.count') do
      post :create, sites_admin_organization_post: {  }
    end

    assert_redirected_to sites_admin_organization_post_path(assigns(:sites_admin_organization_post))
  end

  test "should show sites_admin_organization_post" do
    get :show, id: @sites_admin_organization_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sites_admin_organization_post
    assert_response :success
  end

  test "should update sites_admin_organization_post" do
    patch :update, id: @sites_admin_organization_post, sites_admin_organization_post: {  }
    assert_redirected_to sites_admin_organization_post_path(assigns(:sites_admin_organization_post))
  end

  test "should destroy sites_admin_organization_post" do
    assert_difference('Sites::Admin::OrganizationPost.count', -1) do
      delete :destroy, id: @sites_admin_organization_post
    end

    assert_redirected_to sites_admin_organization_posts_path
  end
end
