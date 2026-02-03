class Wash < ApplicationRecord
  belongs_to :wash_type
  belongs_to :user

  after_create :increase_user_points
  before_destroy :decrease_user_points
  after_update :decrease_user_points

  def increase_user_points
    return unless user.loyalty_enabled

    user.total_points += wash_type.points
    user.save

    return if Rails.env.development?

    if user.total_points >= ENV['SMS_POINTS_NOTIFY'].to_i
      ZoomConnectSmsJob.perform_async(user.contact_number.dup, ENV['SMS_POINTS_MESSAGE'].gsub("<customer_name>", user.name))
    end
  end

  def decrease_user_points
    return if hidden == false

    if hidden == true
      if (user.total_points - wash_type.points) >= 0
        user.total_points -= wash_type.points
      else
        user.total_points = 0
      end

      user.save
    end
  end
end
