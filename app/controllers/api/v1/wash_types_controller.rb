class Api::V1::WashTypesController < Api::V1::ApiController
  private

  def model
    WashType
  end

  def permitted_params
    params.require(:wash_type).permit(:name, :price, :cost, :points)
  end
end
