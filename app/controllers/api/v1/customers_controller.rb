class Api::V1::CustomersController < Api::V1::ApiController
  def index
    if params["contact_number"]
      @instances = model.where("contact_number ILIKE ?", "%#{params['contact_number']}%")
    end

    if params["email"]
      @instances = model.where("email ILIKE ?", "%#{params['email']}%")
    end

    if params["name"]
      @instances = model.where("name ILIKE ?", "%#{params['name']}%")
    end

    if params["registration_number"]
      @instances = model.joins(:vehicles).where("vehicles.registration_number ILIKE ?", "%#{params['registration_number']}%")
    end

    headers['X-Instance-Total'] = instances.count
    render json: paginated_instances
  end

  private

  def model
    Role.find_by_name('customer').users
  end

  def permitted_params
    password = SecureRandom.uuid
    params.require(:customer)
          .permit(:name, :email, :contact_number, vehicles_attributes: [:registration_number])
          .merge({
            :password => password,
            :password_confirmation => password
          })
  end
end
