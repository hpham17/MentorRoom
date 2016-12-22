require 'test_helper'

class FlashSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flash_sessions_index_url
    assert_response :success
  end

end
