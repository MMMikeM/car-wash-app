# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(permitted_params)

    if @user.valid?
      @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(permitted_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    redirect_to users_path
  end

  private

  def find_user
    @user ||= User.find(params[:id])
  rescue ActiveRecord::NotFoundError
    head :unauthorized
  end

  def permitted_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
