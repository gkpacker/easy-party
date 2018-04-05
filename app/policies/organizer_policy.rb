class OrganizerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.role == "Organizador"
  end
end
