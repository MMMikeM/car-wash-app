class Api::V1::WashesController < Api::V1::ApiController
  before_action :add_cost_and_price_new, only: :create
  before_action :add_cost_and_price, only: :update

  private

  def model
    Wash
  end

  def add_cost_and_price_new
    new_instance.cost = wash_type.cost * 100
    new_instance.price = wash_type.price * 100
  end

  def add_cost_and_price
    instance.cost = wash_type.cost * 100
    instance.price = wash_type.price * 100
  end

  def wash_type
    @wash_type ||= WashType.find(permitted_params[:wash_type_id])
  end

  def permitted_params
    params.require(:wash).permit(:wash_type_id, :user_id)
  end
end
