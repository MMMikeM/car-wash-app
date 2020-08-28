class Api::V1::ReportsController < Api::V1::ApiController
  include ActionController::MimeResponds

  def todays_washes
    respond_to do |format|
      format.json do
        render json: todays_washes.as_json
      end
    end
  end

  def washes_report
    respond_to do |format|
      format.json do
        render json: washes.as_json
      end
      format.csv { send_data washes_as_csv, filename: "washes-report-#{Date.today}.csv" }
    end
  end

  private

  def washes
    Wash
      .joins(:wash_type)
      .where("washes.hidden = false")
      .where("washes.created_at >= ? AND washes.created_at <= ?", Date.parse(permitted_params[:start_date]).beginning_of_day, Date.parse(permitted_params[:end_date]).end_of_day)
      .select("wash_types.id, wash_types.name, (SUM(wash_types.cost)) as total_cost, (SUM(wash_types.price)) as total_price, count(washes.*) as wash_count")
      .group("wash_types.name, wash_types.id")
  end


  def todays_washes
    user_ids = Wash
      .where("washes.hidden = false")
      .where("washes.created_at >= ? AND washes.created_at <= ?", Date.parse(permitted_params[:start_date]).beginning_of_day, Date.parse(permitted_params[:end_date]).end_of_day)
      .select(:user_id)
    User.where(id: user_ids.uniq)
  end


  def washes_as_csv
    headings = %w{wash_name total_cost total_income number_of_washes}
    attributes = %w{name total_cost total_price wash_count}

    CSV.generate(headers: true) do |csv|
      csv << headings

      washes.as_json.each do |wash|
        csv << attributes.map{ |attr| wash[attr] }
      end
    end
  end


  def permitted_params
    params.permit(:start_date, :end_date)
  end
end
