require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home page" do
    get :home
    assert_response :success
    assert_not_nil assigns(:books)
    assert_equal 30, assigns(:books).count
  end
end
