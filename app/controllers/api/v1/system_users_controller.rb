class Api::V1::SystemUsersController < Api::V1::ApiController
  def update_roles
    user.roles = []
    user.roles = Role.where(name: permitted_params[:roles])
    user.roles << Role.find_by_name('customer')
    user.save

    render json: user
  end

  private

  def model
    User.joins(:roles).where('roles.name IN (?)', ['manager', 'salesperson'])
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def permitted_params
    params.require(:system_user).permit(roles: [])
  end
end
