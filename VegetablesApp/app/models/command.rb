class Command < ApplicationRecord
  belongs_to :client
  has_many :command_products
  has_many :products, :through => :command_products
end
