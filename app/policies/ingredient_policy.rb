class IngredientPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    @record.recipe.user_id == @user.id
  end

  def update?
    true
  end

  def delete?
    true
  end
end
