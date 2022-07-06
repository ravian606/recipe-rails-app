# == Schema Information
#
# Table name: ingredients
#
#  id         :bigint           not null, primary key
#  unit       :integer          default("cup"), not null
#  amount     :float(24)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :bigint
#
class Ingredient < ApplicationRecord
  include ConstantValidatable

  # jitera-anchor-dont-touch: relations

  belongs_to :recipe

  # jitera-anchor-dont-touch: enum
  enum unit: %w[cup teaspoons gram kilogram], _suffix: true

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :unit, presence: true

  validates :amount,
            numericality: { greater_than: 0.0, less_than: 3.402823466e+38, message: I18n.t('.out_of_range_error') }, presence: true

  # jitera-anchor-dont-touch: reset_password

  class << self
  end
end
