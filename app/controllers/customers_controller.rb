class CustomersController < ApiController
  private

  def model
    "User".constantize
  end

  def permitted_params
    password = SecureRandom.uuid
    params.require(:customer)
          .permit(:name, :email, :contact_number, vehicles_attributes: [:registration_number] )
          .merge({
            :password => password,
            :password_confirmation => password
          })
  end
end
