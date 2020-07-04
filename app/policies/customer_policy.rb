class CustomerPolicy < ApplicationPolicy
  def show?
    self?
  end

  class Scope
    def resolve
      if user.roles.where(name: %i(sysadmin manager salesperson)).any?
        scope.all
      else
        scope.none
      end
    end
  end

  private

  def self?
    record == user
  end
end
