class Product < ApplicationRecord
  has_many :command_products
  has_many :category_products
  has_many :commands, through: :command_products
  has_many :categories, through: :category_products
end
