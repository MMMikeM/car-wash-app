class WashType < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :cost, presence: true, numericality: true
  validates :points, presence: true, numericality: true

  belongs_to :branch
end
