class Api::V1::WashTypesController < Api::V1::ApiController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    render json: paginated_instances
  end

  private

  def model
    WashType
  end

  def permitted_params
    params.require(:wash_type).permit(:name, :description, :price, :cost, :points, :order)
  end
end
