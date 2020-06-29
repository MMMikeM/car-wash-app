class ApiController < ActionController::API
  def index
    all_instances = model.all
    render json: all_instances
  end

  def show
    instance = model.find(params[:id])

    render json: instance
  end

  def create
    instance = model.new(permitted_params)

    if instance.valid?
      instance.save
      render json: instance
    else
      render json: { errors: instance.errors.full_messages }
    end
  end

  def update
    instance = model.find(params[:id])

    if instance.update(permitted_params)
      render json: instance
    else
      render json: { errors: instance.errors.full_messages }
    end
  end

  def destroy
    instance = model.find(params[:id])

    if instance.destroy
      render json: { message: "#{model} deleted successfully" }
    else
      render json: { errors: instance.errors.full_messages }
    end
  end
end
