require 'test_helper'

class IncompleteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get incomplete_index_url
    assert_response :success
  end

end
