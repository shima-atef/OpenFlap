require "test_helper"

class Users::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_profiles_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_profiles_update_url
    assert_response :success
  end
end
