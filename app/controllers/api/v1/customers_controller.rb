class Api::V1::CustomersController < Api::V1::ApiController
  include ActionController::MimeResponds

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

    respond_to do |format|
      format.json do
        render json: paginated_instances
      end
      format.csv { send_data customers_as_csv, filename: "customers-#{Date.today}.csv" }
    end
  end

  private

  def model
    Role.find_by_name('customer').users.distinct
  end

  def customers_as_csv
    headings = %w{Name Email ContactNumber}
    attributes = %w{name email contact_number}

    CSV.generate(headers: true) do |csv|
      csv << headings

      instances.as_json.each do |wash|
        csv << attributes.map{ |attr| wash[attr] }
      end
    end
  end

  def permitted_params
    password = SecureRandom.uuid
    params.require(:customer)
          .permit(:name, :email, :contact_number, :opted_for_marketing, vehicles_attributes: [:registration_number])
          .merge({
            :password => password,
            :password_confirmation => password
          })
  end
end
