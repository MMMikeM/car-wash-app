class Api::V1::CustomersController < Api::V1::ApiController
  private

  def model
    User
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
