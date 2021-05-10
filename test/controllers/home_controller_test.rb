require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "RhoHi"
  end

  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get about" do
    get home_about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get help" do
    get home_help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

end
