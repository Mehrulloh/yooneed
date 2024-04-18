class Supervisor::UserPolicy < ApplicationPolicy
  def create?
    user.has_role? :supervisor
  end
  def update?
    user.has_role? :supervisor
  end

  def destroy?
    user.has_role? :supervisor
  end

  def index?
    user.has_role? :supervisor
  end

  def show?
    user.has_role? :supervisor
  end
end