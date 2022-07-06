class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :score, default: 0, null: false
      t.timestamps
    end
  end
end
