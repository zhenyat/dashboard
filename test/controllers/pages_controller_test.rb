require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get dashboard1" do
    get :dashboard1
    assert_response :success
  end

  test "should get dashboard2" do
    get :dashboard2
    assert_response :success
  end

  test "should get dashboard3" do
    get :dashboard3
    assert_response :success
  end

  test "should get dashboard4" do
    get :dashboard4
    assert_response :success
  end

end
