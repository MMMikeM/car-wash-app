class WashesController < ApplicationController
  before_action :find_customer, only: %i{new create}
  before_action :define_wash_types, only: %i{new create}

  def new
    @wash = Wash.new(user_id: @customer.id, wash_type_id: WashType.first)
  end

  def create
    @wash = Wash.new(
      wash_type_id: permitted_params[:wash_type_id],
      user: @customer,
      free: false
    )

    if @wash.valid?
      @wash.save
      @customer.update(current_points: @customer.current_points + @wash.wash_type.points)
      redirect_to customers_path
    else
      render :new
    end
  end
  
  private

  def find_customer
    # id = params[:id].present? ? params[:id] : params[:customer_id]
    id = params[:customer_id]
    @customer ||= User.find(id)
  rescue ActiveRecord::NotFoundError
    head :unauthorized
  end

  def define_wash_types
    @wash_types = WashType.order(:price)
  end

  def permitted_params
    params.permit(:wash_type_id)
  end
end
