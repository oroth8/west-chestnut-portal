# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  before_validation :profile_complete?
  before_save :upcase_unit_field

  validates :name, length: { in: 2..30 }, on: :update
  validates :address, length: { in: 4..50 }, on: :update
  validates :unit, length: { in: 1..10 }, on: :update
  validates :city, length: { in: 2..30 }, on: :update
  validates :postal_code, length: { is: 5 }, on: :update

  USER_FIELDS = %i[name email address unit city postal_code].freeze

  def profile_complete?
    check_for_empty_fields.empty?
  end

  def missing_fields
    profile_complete? ? nil : check_for_empty_fields
  end

  private

  def check_for_empty_fields
    USER_FIELDS.select { |f| __send__(f).blank? }
  end

  def upcase_unit_field
    return unit.upcase! if self&.unit
  end
end
