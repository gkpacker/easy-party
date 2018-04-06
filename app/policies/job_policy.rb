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
    @record.event.organizer == @user
  end

  def edit?
    update?
  end

  def destroy?
    @record.event.organizer == @user
  end

  def accept?
    @record.professional == @user
  end

  def decline?
    @record.professional == @user
  end
end
