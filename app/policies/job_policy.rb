class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    @user.role == "Organizador"
  end

  def new?
    create?
  end

  def update?
    @record.user == @user
  end

  def destroy?
    @record.event.organizer == @user
  end
end
