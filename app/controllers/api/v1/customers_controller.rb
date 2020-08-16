class Api::V1::CustomersController < Api::V1::ApiController
  skip_around_action :with_authorized_instance, only: [:create, :update_password, :reset_password]
  acts_as_token_authentication_handler_for User, except: [:create, :update_password, :reset_password]
  include ActionController::MimeResponds
  before_action :add_email_to_customer, only: :create

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

  def reset_password
    user = User.find_by(contact_number: params[:contact_number])

    if user
      message = "You can reset your password by clicking on the following link: #{ENV['WEBSITE_URL']}/#{user.id}/reset_password"
      ZoomConnectSmsJob.perform_async(user.contact_number, message)
    end
  end

  def update_password
    User.find(params[:customer_id])
        .update(
          password: params[:password],
          password_confirmation: params[:password_confirmation])
  end

  private

  def add_email_to_customer
    #if !params[:email].present? ||params[:email].empty?
    if !params[:email].present?
      new_instance.email = "#{SecureRandom.uuid}@carboncarwash.co.za"
    end
  end

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

  def password
    @password ||= params[:password].present? ? params[:password] : SecureRandom.uuid
  end

  def permitted_params
    params.require(:customer)
          .permit(:name, :email, :contact_number, :opted_for_marketing, vehicles_attributes: [:registration_number])
          .merge({
            :password => password,
            :password_confirmation => password
          })
  end
end
