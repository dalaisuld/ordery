require 'test_helper'

class SmsLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sms_logs_index_url
    assert_response :success
  end

end
