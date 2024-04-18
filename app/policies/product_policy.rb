class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.has_role?(:supervisor) || !user.has_role?(:gast) || user.author?(record)
  end

  def update?
    user.has_role?(:supervisor) || !user.has_role?(:gast) ||user.author?(record)
  end

  def destroy?
    user.has_role?(:supervisor) || !user.has_role?(:gast) ||user.author?(record)
  end
end
