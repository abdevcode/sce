class CommandProduct < ApplicationRecord
  belongs_to :product
  belongs_to :command
end
