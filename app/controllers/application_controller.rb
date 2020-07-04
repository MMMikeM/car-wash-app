class ApplicationController < ActionController::API
  private
  
  def per_page
    if params[:per_page] && (@per_page = params[:per_page].to_i.abs).positive?
      per_page
    else
      100
    end
  end

  def page
    if params[:page] && (page = params[:page].to_i.abs).positive?
      page
    else
      0
    end
  end

  def offset
    per_page * page
  end
end
