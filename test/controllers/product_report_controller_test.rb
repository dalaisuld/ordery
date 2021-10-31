require 'test_helper'

class ProductReportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_report_index_url
    assert_response :success
  end

end
