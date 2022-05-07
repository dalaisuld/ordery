require 'test_helper'

class CargoPriceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cargo_price_index_url
    assert_response :success
  end

end
