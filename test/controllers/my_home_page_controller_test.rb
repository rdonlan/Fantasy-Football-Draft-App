require 'test_helper'

class MyHomePageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get my_home_page_home_url
    assert_response :success
  end

end
