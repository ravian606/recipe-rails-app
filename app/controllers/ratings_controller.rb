class RatingsController < ApplicationController
    before_action :get_recipe
    before_action :set_ratings, only: [:show, :edit, :update, :destroy]
    
    def index
        @ratings = @recipe.ratings
    end

    def show
    end

    def new
        @ratings = @recipe.ratings.build
    end

    def edit
    end

    def create
        @ratings = @recipe.ratings.build(ratings_params)
        @ratings.user_id = current_user.id
        respond_to do |format|
            if @ratings.save
                format.html { redirect_to recipe_ratings_path(@ratings), notice: 'Rating was successfully added.' }
                format.json { render :show, status: :created, location: @ratings }
            else
                format.html { render :new }
                format.json { render json: @recipe.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
        if @ratings.update(ratings_params)
            format.html { redirect_to recipes_ratings_path(@recipe), notice: 'Rating was successfully updated.' }
            format.json { render :show, status: :ok, location: @ratings }
        else
            format.html { render :edit }
            format.json { render json: @ratings.errors, status: :unprocessable_entity }
        end
        end
    end

    def destroy
        @ratings.destroy
        respond_to do |format|
        format.html { redirect_to recipes_ratings_path(@recipe), notice: 'Rating was successfully destroyed.' }
        format.json { head :no_content }
        end
    end

    def add_ratings
        #byebug
        @rating = Rating.new
        @rating.score = params[:score]
        @rating.user_id = params[:user_id]
        @rating.recipe_id = params[:recipe_id]
        @rating.save 

        redirect_to(recipes_path)
    end


    private

    def get_recipe
        @recipe = Recipe.find(params[:recipe_id])
    end
    def set_ratings
        @ratings = @recipe.ratings.find(params[:id])
    end
    
    def ratings_params
        params.require(:rating).permit(
            :score,
            :recipe_id,
            :user_id
        )
    end
    
end
