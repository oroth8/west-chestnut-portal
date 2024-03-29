# frozen_string_literal: true

# rails test 'test/controllers/units_controller_test.rb'

require 'test_helper'

class UnitsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:owen)
    @unit = units(:one_e)
  end

  test 'should get index' do
    get units_url
    assert_response :success
  end

  test 'should get new' do
    get new_unit_url
    assert_response :success
  end

  test 'should create unit' do
    assert_difference('Unit.count') do
      post units_url,
           params: { unit: { name: @unit.name, number: @unit.number, organisation_id: @unit.organisation_id } }
    end

    assert_redirected_to unit_url(Unit.last)
  end

  test 'should show unit' do
    get unit_url(@unit)
    assert_response :success
  end

  test 'should get edit' do
    get edit_unit_url(@unit)
    assert_response :success
  end

  test 'should update unit' do
    patch unit_url(@unit),
          params: { unit: { name: @unit.name, number: @unit.number, organisation_id: @unit.organisation_id } }
    assert_redirected_to unit_url(@unit)
  end

  test 'should destroy unit' do
    assert_difference('Unit.count', -1) do
      delete unit_url(@unit)
    end

    assert_redirected_to units_url
  end
end
