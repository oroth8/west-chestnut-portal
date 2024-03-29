# frozen_string_literal: true

require 'test_helper'

class OrganisationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:owen)
    @organisation = organisations(:west_chestnut)
  end

  test 'should get index' do
    get organisations_url
    assert_response :success
  end

  test 'should get new' do
    get new_organisation_url
    assert_response :success
  end

  test 'should create organisation' do
    assert_difference('Organisation.count') do
      post organisations_url,
           params: { organisation: { capacity: @organisation.capacity, name: @organisation.name } }
    end

    assert_redirected_to organisation_url(Organisation.last)
  end

  test 'should show organisation' do
    get organisation_url(@organisation)
    assert_response :success
  end

  test 'should get edit' do
    get edit_organisation_url(@organisation)
    assert_response :success
  end

  test 'should update organisation' do
    patch organisation_url(@organisation),
          params: { organisation: { capacity: @organisation.capacity, name: @organisation.name } }
    assert_redirected_to organisation_url(@organisation)
  end

  test 'should destroy organisation' do
    assert_difference('Organisation.count', -1) do
      delete organisation_url(@organisation)
    end

    assert_redirected_to organisations_url
  end
end
