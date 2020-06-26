class BranchesController < ApplicationController
  def index
    @branches = Branch.all
  end

  def show
    @branch = Branch.find(params[:id])
  end
end
