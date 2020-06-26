class CustomersController < ApplicationController
  before_action :find_customer, only: %i{show}

  def index
    @branch = Branch.find(params[:branch_id])
    @customers = @branch.users
  end

  def show
  end

  private

  def find_customer
    id = params[:id]
    @customer ||= User.find(id)
  rescue ActiveRecord::NotFoundError
    head :unauthorized
  end
end
