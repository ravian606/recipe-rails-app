module RecipesHelper
    def difficulty_options_for_recipe
        [
            'easy', 'normal', 'challenging'
        ]
    end

    def unit_options_for_ingredients
        %w[cup teaspoons gram kilogram]
    end

    def can_add_rating?
        return false if recipe_author? || rating_already_added?

        true
    end

    def recipe_author?
        @recipe.user_id == current_user.id
    end

    def rating_already_added?
        @recipe.ratings.find_by(user_id: current_user.id)
    end

    
end


