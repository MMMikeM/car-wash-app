class Api::V1::ReportsController < Api::V1::ApiController
  def washes_report
    render json: washes.as_json
  end

  private

  def washes
    Wash
      .joins(:wash_type)
      .where("washes.created_at >= ? AND washes.created_at <= ?", permitted_params[:start_date].to_date.beginning_of_day, permitted_params[:end_date].to_date.end_of_day)
      .select("wash_types.id, wash_types.name, (SUM(wash_types.cost)) as total_cost, (SUM(wash_types.price)) as total_price, count(washes.*) as wash_count")
      .group("wash_types.name, wash_types.id")
  end


  def permitted_params
    params.permit(:start_date, :end_date)
  end
end
