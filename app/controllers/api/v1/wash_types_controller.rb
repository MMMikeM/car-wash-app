class Api::V1::WashTypesController < Api::V1::ApiController
  acts_as_token_authentication_handler_for User, except: [:index]

  def index
    render json: paginated_instances
  end

  def bulk_update
    bulk_wash_type_params.each do |bulk_wash_type_param|
      WashType.find(bulk_wash_type_param[:id]).update(order: bulk_wash_type_param[:order].to_i)
    end

    render json: paginated_instances
  end

  private

  def model
    WashType
  end

  def permitted_params
    params.require(:wash_type).permit(:name, :description, :price, :cost, :points, :order, :insurance)
  end

  def bulk_wash_type_params
    params.require(:wash_types)
  end
end
