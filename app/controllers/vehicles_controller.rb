class VehiclesController < ApiController
  private

  def model
    "Vehicle".constantize
  end

  def permitted_params
    params.require(:vehicle)
          .permit(:registration_number, :user_id)
  end
end
