require 'test_helper'

class DistributionsControllerTest < ActionController::TestCase
  setup do
    @distribution = distributions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:distributions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create distribution" do
    assert_difference('Distribution.count') do
      post :create, distribution: { interval: @distribution.interval, value: @distribution.value, wideness: @distribution.wideness }
    end

    assert_redirected_to distribution_path(assigns(:distribution))
  end

  test "should show distribution" do
    get :show, id: @distribution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @distribution
    assert_response :success
  end

  test "should update distribution" do
    put :update, id: @distribution, distribution: { interval: @distribution.interval, value: @distribution.value, wideness: @distribution.wideness }
    assert_redirected_to distribution_path(assigns(:distribution))
  end

  test "should destroy distribution" do
    assert_difference('Distribution.count', -1) do
      delete :destroy, id: @distribution
    end

    assert_redirected_to distributions_path
  end
end
