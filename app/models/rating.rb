# == Schema Information
#
# Table name: ratings
#
#  id         :bigint           not null, primary key
#  score      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :bigint
#  user_id    :bigint
#
class Rating < ApplicationRecord
    # jitera-anchor-dont-touch: relations

    belongs_to :recipe
    belongs_to :user
    validates :score,
            numericality: { greater_than: 0, less_than: 3.402823466e+38, message: I18n.t('.out_of_range_error') }, presence: true

    class << self
    end
end
