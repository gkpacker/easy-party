class ProfessionalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.role == "Profissional"
  end
end
