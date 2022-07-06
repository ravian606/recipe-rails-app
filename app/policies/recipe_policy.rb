class RecipePolicy < ApplicationPolicy
  def filter?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    !@user.nil?
  end

  def edit?
    update?
  end

  def update?
    @record.user_id == @user.id
  end

  def delete?
    @record.user_id == @user.id
  end
end
