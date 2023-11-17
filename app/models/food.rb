class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { only_integer: true }
  validates :quantity, numericality: { only_integer: true }
end
