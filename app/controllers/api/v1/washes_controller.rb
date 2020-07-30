class Api::V1::WashesController < Api::V1::ApiController
  private

  def model
    Wash
  end

  def permitted_params
    params.require(:wash).permit(:wash_type_id, :user_id)
  end
end
