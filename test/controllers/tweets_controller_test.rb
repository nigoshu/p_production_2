require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get tweets_top_url
    assert_response :success
  end

  test "should get info" do
    get tweets_info_url
    assert_response :success
  end

end
