class Institutional < ApplicationRecord
  validates :description,   presence: true
  validates :phone_numbers, presence: true
end
