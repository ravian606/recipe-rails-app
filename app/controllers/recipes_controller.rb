class RecipesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_recipe, only: [:show, :edit, :update, :destroy]

    def index
        if params[:search]
            @recipes = search_recipes_by_title
        elsif params[:difficulty]
            @recipes = search_recipes_by_difficulty
        elsif params[:time]
            @recipes = search_recipes_by_time
        else
            @recipes = Recipe.includes(:user).all
        end

        respond_to do |format|
            format.html
        end
    end

    def new
        @recipe = Recipe.new
        @recipe.ingredients.build
        @recipe.ratings.build
    end

    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.user_id = current_user.id if current_user
        @recipe.category_id = 1
        authorize @recipe
        
        if @recipe.save
            flash[:notice] = 'Recipe Created Successfully'
        else
            flash.now[:error] = @recipe.errors.full_messages
        end
        
        respond_to do |format|
            format.html { @recipe.persisted? ? redirect_to(@recipe) : render(:new) }
        end
    end

    def show
        @ratings = Rating.new(:recipe=>@recipe)
    end

    def edit
        authorize @recipe
    end

    def update
        authorize @recipe

        success = false
        if @recipe.update(recipe_params)
            flash[:notice] = 'Recipe Updated Successfully'
            success = true
        else
            flash.now[:error] = @recipe.errors.full_messages
        end
        
        respond_to do |format|
            format.html { success ? redirect_to(@recipe) : render(:edit) }
        end
    end

    def delete

    end

    def destroy
        if @recipe.destroy
            flash[:notice] = 'Deleted Recipe Successfully'
          else
            flash[:error] = 'Could not delete recipe due to some errors'
          end
          respond_to do |format|
            format.html { @recipe.destroyed? ? redirect_to(recipes_path) : redirect_to(@recipe.id) }
          end
    end

    private 
    def recipe_params
        params.require(:recipe).permit(
            :title,
            :descriptions,
            :difficulty,
            :time,
            ingredients_attributes: [:unit, :amount]
        )
    end

    def search_recipes_by_title
        Recipe.includes(:user).all.where(title: params[:search])
    end

    def search_recipes_by_difficulty
        Recipe.includes(:user).all.where(difficulty: params[:difficulty])
    end

    def search_recipes_by_time
        Recipe.includes(:user).all.where(time: params[:time])
    end

    def set_recipe
        @recipe = Recipe.find(params[:id])
    end


end
