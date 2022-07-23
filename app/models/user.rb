# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable
  enum role: { guest: 0, standard: 1, owner: 2, admin: 3 }

  after_initialize do
    self.role ||= :standard if new_record?
  end

  before_validation :profile_complete?

  validates :name, length: { in: 2..30 }, on: :update
  validates :address, length: { in: 4..50 }, on: :update
  validates :city, length: { in: 2..30 }, on: :update
  validates :postal_code, length: { is: 5 }, on: :update
  validates :unit, presence: true, on: :update
  validate :organisation, on: :create
  validate :check_registration_code, on: :create

  USER_FIELDS = %i[name email address unit_id organisation_id city postal_code].freeze

  belongs_to :organisation
  belongs_to :unit, optional: true

  def profile_complete?
    check_for_empty_fields.empty?
  end

  def missing_fields
    profile_complete? ? nil : check_for_empty_fields
  end

  def admin?
    self.role == 'admin'
  end

  def owner?
    self.role == 'owner'
  end

  def standard?
    self.role = 'standard'
  end

  private

  def check_for_empty_fields
    USER_FIELDS.select { |f| __send__(f).blank? }
  end

  def check_registration_code
    org = Organisation.find_by(id: organisation_id.to_i)
    errors.add(:registration_code, 'Invalid Registration Code') if org.nil?
  end
end
