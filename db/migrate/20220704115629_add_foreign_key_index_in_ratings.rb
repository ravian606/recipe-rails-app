class AddForeignKeyIndexInRatings < ActiveRecord::Migration[7.0]
  def change
    add_reference :ratings, :recipe, foreign_key: true
  end
end
