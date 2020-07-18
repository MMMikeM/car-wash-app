class Api::V1::ApiController < ApplicationController
  acts_as_token_authentication_handler_for User
  around_action :with_authorized_instance, only: %i(show update destroy)

  def index
    headers['X-Instance-Total'] = instances.count
    render json: paginated_instances
  end

  def show
    render json: instance
  end

  def create
    if new_instance.save
      render json: new_instance
    else
      render json: { errors: new_instance.errors.full_messages }
    end
  end

  def update
    if instance.update(permitted_params)
      render json: instance
    else
      render json: { errors: instance.errors.full_messages }
    end
  end

  def destroy
    if instance.destroy
      render json: { message: "#{model} deleted successfully" }
    else
      render json: { errors: instance.errors.full_messages }
    end
  end

  private

  def instances
    @instances ||= model.all
  end

  def paginated_instances
    @paginated_instances ||= instances.limit(per_page).offset(offset)
  end

  def new_instance
    @new_instance ||= model.new(permitted_params)
  end

  def with_authorized_instance
    @instance ||= model.find(params[:id])
    yield
  rescue ActiveRecord::RecordNotFound
    render json: { message: "#{params[:id]} was not found."}, status: :not_found
  end

  def instance
    @instance
  end

  def model
    raise "You haven't defined a model for #{self.class}!"
  end

  def permitted_params
    raise "You haven't defined permitted params for #{self.class}"
  end

  def per_page
    if params[:per_page] && (params[:per_page].to_i.abs).positive?
      @per_page = params[:per_page]
    else
      100
    end
  end

  def page
    if params[:page] && (params[:page].to_i.abs).positive?
      @page = params[:page]
    else
      0
    end
  end

  def offset
    per_page * page
  end
end
