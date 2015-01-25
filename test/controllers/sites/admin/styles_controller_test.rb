require 'test_helper'

class Sites::Admin::StylesControllerTest < ActionController::TestCase
  setup do
    @sites_admin_style = sites_admin_styles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites_admin_styles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sites_admin_style" do
    assert_difference('Sites::Admin::Style.count') do
      post :create, sites_admin_style: {  }
    end

    assert_redirected_to sites_admin_style_path(assigns(:sites_admin_style))
  end

  test "should show sites_admin_style" do
    get :show, id: @sites_admin_style
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sites_admin_style
    assert_response :success
  end

  test "should update sites_admin_style" do
    patch :update, id: @sites_admin_style, sites_admin_style: {  }
    assert_redirected_to sites_admin_style_path(assigns(:sites_admin_style))
  end

  test "should destroy sites_admin_style" do
    assert_difference('Sites::Admin::Style.count', -1) do
      delete :destroy, id: @sites_admin_style
    end

    assert_redirected_to sites_admin_styles_path
  end
end
