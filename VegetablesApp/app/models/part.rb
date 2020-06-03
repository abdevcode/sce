class Part < ApplicationRecord
  belongs_to :command
  belongs_to :product
end
