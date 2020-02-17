require 'test_helper'

class EventBookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get event_bookings_index_url
    assert_response :success
  end

end
