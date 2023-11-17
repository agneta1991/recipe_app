class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, presence: true
  validates :preparation_time, numericality: { allow_float: true, greater_than_or_equal_to: 0 }
  validates :cooking_time, numericality: { allow_float: true, greater_than_or_equal_to: 0 }

  def total_food_items
    recipe_foods.sum(:quantity)
  end

  def total_price
    recipe_foods.joins(:food).sum('recipe_foods.quantity * foods.price')
  end
end
