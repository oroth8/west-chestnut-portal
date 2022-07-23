class OrganisationPolicy < ApplicationPolicy
  def show?
    auth_user?
  end

  def update?
    auth_user?
  end

  def edit?
    auth_user?
  end

  def destroy?
    auth_user?
  end

  private

  def auth_user?
    admin || owner
  end
end
