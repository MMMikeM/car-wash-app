class VehiclePolicy < ApplicationPolicy
  def show?
    own?
  end

  class Scope
    def resolve
      if user.roles.where(name: %i(sysadmin manager salesperson)).any?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  private

  def self?
    user.vehicles.include?(record)
  end
end
