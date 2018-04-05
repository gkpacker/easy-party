class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(organizer: @user)
    end
  end

  def show?
    @record.organizer == @user
  end

  def create?
    @user.role == "Organizador"
  end

  def update?
    @record.organizer == @user
  end

  def destroy?
    @record.organizer == @user
  end
end
