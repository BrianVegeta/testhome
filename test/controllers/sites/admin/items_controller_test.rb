require 'test_helper'

class Sites::Admin::ItemsControllerTest < ActionController::TestCase
  setup do
    @sites_admin_item = sites_admin_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites_admin_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sites_admin_item" do
    assert_difference('Sites::Admin::Item.count') do
      post :create, sites_admin_item: {  }
    end

    assert_redirected_to sites_admin_item_path(assigns(:sites_admin_item))
  end

  test "should show sites_admin_item" do
    get :show, id: @sites_admin_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sites_admin_item
    assert_response :success
  end

  test "should update sites_admin_item" do
    patch :update, id: @sites_admin_item, sites_admin_item: {  }
    assert_redirected_to sites_admin_item_path(assigns(:sites_admin_item))
  end

  test "should destroy sites_admin_item" do
    assert_difference('Sites::Admin::Item.count', -1) do
      delete :destroy, id: @sites_admin_item
    end

    assert_redirected_to sites_admin_items_path
  end
end
