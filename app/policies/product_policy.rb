class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.role_supervisor? || !user.role_gast? || user.author?(record)
  end

  def update?
    user.role_supervisor? || !user.role_gast? ||user.author?(record)
  end

  def destroy?
    user.role_supervisor? || !user.role_gast? ||user.author?(record)
  end
end
