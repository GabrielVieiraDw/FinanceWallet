require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_wallet" do
    get users_my_wallet_url
    assert_response :success
  end
end
