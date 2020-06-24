class WashTypesController < ApplicationController
  before_action :set_wash_type, only: [:show, :edit, :update, :destroy]

  # GET /wash_types
  def index
    @wash_types = WashType.all
  end

  # GET /wash_types/1
  def show
  end

  # GET /wash_types/new
  def new
    @wash_type = WashType.new
  end

  # GET /wash_types/1/edit
  def edit
  end

  # POST /wash_types
  def create
    @wash_type = WashType.new(wash_type_params)

    respond_to do |format|
      if @wash_type.save
        format.html { redirect_to @wash_type, notice: 'Wash type was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /wash_types/1
  def update
    respond_to do |format|
      if @wash_type.update(wash_type_params)
        format.html { redirect_to @wash_type, notice: 'Wash type was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /wash_types/1
  # DELETE /wash_types/1.json
  def destroy
    @wash_type.destroy
    respond_to do |format|
      format.html { redirect_to wash_types_url, notice: 'Wash type was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wash_type
      @wash_type = WashType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wash_type_params
      params.require(:wash_type).permit(:name, :cost, :price)
    end
end
