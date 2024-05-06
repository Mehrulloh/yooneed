class Supervisor::UserPolicy < ApplicationPolicy
  def create?
    user.role_supervisor?
  end
  def update?
    user.role_supervisor?
  end

  def destroy?
    user.role_supervisor?
  end

  def index?
    user.role_supervisor?
  end

  def show?
    user.role_supervisor?
  end
end