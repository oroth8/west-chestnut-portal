class UnitPolicy < ApplicationPolicy
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

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(organisation: user.organisation)
      end
    end
  end

  private

  def auth_user?
    admin || owner
  end
end
