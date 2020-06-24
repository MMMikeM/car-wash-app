class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    redirect_to users_index_path
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(permitted_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  private

  def permitted_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
