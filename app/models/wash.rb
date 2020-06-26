class Wash < ApplicationRecord
  belongs_to :wash_type
  belongs_to :user
end
