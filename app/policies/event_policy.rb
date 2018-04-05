class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def create?
    @user.role == "Organizador"
  end

  def update?
    @record.organizer == @user
  end

  def destroy?
    @record.user == @user
  end
end
