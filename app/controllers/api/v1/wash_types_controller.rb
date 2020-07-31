class Api::V1::WashTypesController < Api::V1::ApiController
  acts_as_token_authentication_handler_for User, except: [:index]

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
