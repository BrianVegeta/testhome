require 'test_helper'

class Admin::StylesControllerTest < ActionController::TestCase
  setup do
    @admin_style = admin_styles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_styles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_style" do
    assert_difference('Admin::Style.count') do
      post :create, admin_style: {  }
    end

    assert_redirected_to admin_style_path(assigns(:admin_style))
  end

  test "should show admin_style" do
    get :show, id: @admin_style
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_style
    assert_response :success
  end

  test "should update admin_style" do
    patch :update, id: @admin_style, admin_style: {  }
    assert_redirected_to admin_style_path(assigns(:admin_style))
  end

  test "should destroy admin_style" do
    assert_difference('Admin::Style.count', -1) do
      delete :destroy, id: @admin_style
    end

    assert_redirected_to admin_styles_path
  end
end
