class Api::V1::ReportsController < Api::V1::ApiController
  def washes_report
    render json: washes.as_json
  end

  private

  def washes
    Wash
      .joins(:wash_type)
      .where("washes.created_at >= ? AND washes.created_at <= ?", permitted_params[:start_date], permitted_params[:end_date])
      .select("wash_types.id, wash_types.name, (SUM(wash_types.cost) / 100) as cost, (SUM(wash_types.price) / 100) as price, count(washes.*) as wash_count")
      .group("wash_types.name, wash_types.id")
  end


  def permitted_params
    params.permit(:start_date, :end_date)
  end
end
