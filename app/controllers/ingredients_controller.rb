class IngredientsController < ApplicationController
    before_action :get_recipe
    before_action :set_ingredients, only: [:show, :edit]
    
    def index
        @ingredients = @recipe.ingredients
    end

    def show
    end

    def new
        @ingredients = @recipe.ingredients.build
        authorize @ingredients 
    end

    def edit
    end

    def create
        @ingredients = @recipe.ingredients.build(ingredients_params)
        authorize @ingredients

        respond_to do |format|
            if @ingredients.save
                format.html { redirect_to recipe_path(@recipe.id), notice: 'Ingredient was successfully added.' }
                format.json { render :show, status: :created, location: @ingredients }
            else
                format.html { render :new }
                format.json { render json: @recipe.errors, status: :unprocessable_entity }
            end
        end
    end

    private
    def get_recipe
        @recipe = Recipe.find(params[:recipe_id])
    end

    def set_ingredients
        @ingredients = @recipe.ingredients.find(params[:id])
    end
    
    def ingredients_params
        params.require(:ingredient).permit(
            :amount,
            :recipe_id,
            :unit
        )
    end
end
