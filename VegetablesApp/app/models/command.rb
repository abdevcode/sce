class Command < ApplicationRecord
  belongs_to :client
  has_many :products, through: :parts
end
