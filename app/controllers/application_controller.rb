class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def authenticate_user!
    if user_signed_in?
      super
    else
      render status: 401
    end
  end
end
