require 'test_helper'

class Sites::Admin::OrgansubsControllerTest < ActionController::TestCase
  setup do
    @sites_admin_organsub = sites_admin_organsubs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites_admin_organsubs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sites_admin_organsub" do
    assert_difference('Sites::Admin::Organsub.count') do
      post :create, sites_admin_organsub: {  }
    end

    assert_redirected_to sites_admin_organsub_path(assigns(:sites_admin_organsub))
  end

  test "should show sites_admin_organsub" do
    get :show, id: @sites_admin_organsub
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sites_admin_organsub
    assert_response :success
  end

  test "should update sites_admin_organsub" do
    patch :update, id: @sites_admin_organsub, sites_admin_organsub: {  }
    assert_redirected_to sites_admin_organsub_path(assigns(:sites_admin_organsub))
  end

  test "should destroy sites_admin_organsub" do
    assert_difference('Sites::Admin::Organsub.count', -1) do
      delete :destroy, id: @sites_admin_organsub
    end

    assert_redirected_to sites_admin_organsubs_path
  end
end
