# frozen_string_literal: true

require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:brooks)
  end
  test 'should redirect to login if NOT logged in' do
    get dashboard_path
    assert_redirected_to new_session_path
  end

  test 'should render dashboard if user logged in' do
    sign_in @user
    get dashboard_path
    assert_response :success
  end

  test 'should redirect to dashboard if user logged in' do
    sign_in @user
    get root_path
    assert_redirected_to dashboard_path
  end
end
