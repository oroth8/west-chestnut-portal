# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @basic_user = users(:basic_user)
    @unit = units(:one_e)
  end
  test 'user can be updated via params' do
    sign_in @basic_user
    get dashboard_path
    assert_response :success
    put user_path(@basic_user),
        params: {
          user: {
            name: 'Owen Roth',
            address: '145 Home',
            postal_code: '12345',
            unit: @unit,
            city: 'ktown'
          },
          id: @basic_user.id
        }
    assert_redirected_to dashboard_path

    assert @basic_user.reload.profile_complete?
  end

  test 'user cannot be updated with incorrect params and is redirected' do
    user = @basic_user
    sign_in user
    get dashboard_path
    assert_response :success
    put user_path(@basic_user),
        params: {
          user: {
            name: 'Owen Roth',
            address: '',
            postal_code: '12345123123',
            unit: @unit,
            city: 'ktown'
          },
          id: @basic_user.id
        }
    assert_response :unprocessable_entity

    assert_not @basic_user.reload.profile_complete?
  end
end
