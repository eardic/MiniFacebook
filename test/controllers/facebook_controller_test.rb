require 'test_helper'

class FacebookControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get find_friends" do
    get :find_friends
    assert_response :success
  end

end
