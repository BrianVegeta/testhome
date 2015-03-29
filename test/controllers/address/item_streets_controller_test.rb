require 'test_helper'

class Address::ItemStreetsControllerTest < ActionController::TestCase
  setup do
    @address_item_street = address_item_streets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:address_item_streets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address_item_street" do
    assert_difference('Address::ItemStreet.count') do
      post :create, address_item_street: {  }
    end

    assert_redirected_to address_item_street_path(assigns(:address_item_street))
  end

  test "should show address_item_street" do
    get :show, id: @address_item_street
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @address_item_street
    assert_response :success
  end

  test "should update address_item_street" do
    patch :update, id: @address_item_street, address_item_street: {  }
    assert_redirected_to address_item_street_path(assigns(:address_item_street))
  end

  test "should destroy address_item_street" do
    assert_difference('Address::ItemStreet.count', -1) do
      delete :destroy, id: @address_item_street
    end

    assert_redirected_to address_item_streets_path
  end
end
