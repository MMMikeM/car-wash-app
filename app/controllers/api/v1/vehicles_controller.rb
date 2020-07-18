class Api::V1::VehiclesController < Api::V1::ApiController
  private

  def model
    Vehicle
  end

  def permitted_params
    params.require(:vehicle)
          .permit(:registration_number, :user_id)
  end
end
