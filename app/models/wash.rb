class Wash < ApplicationRecord
  belongs_to :wash_type
  belongs_to :user

  after_create :increase_user_points
  before_destroy :decrease_user_points

  def increase_user_points
    user.total_points += wash_type.points
    user.save

    if user.total_points >= ENV['SMS_POINTS_NOTIFY'].to_i
      #ZoomConnectSmsJob.perform_async(user.contact_number.dup, ENV['SMS_POINTS_MESSAGE'])
    end
  end

  def decrease_user_points
    if (user.total_points - wash_type.points) >= 0
      user.total_points -= wash_type.points
    else
      user.total_points = 0
    end

    user.save
  end
end
