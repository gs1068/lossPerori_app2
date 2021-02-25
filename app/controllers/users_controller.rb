class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "プロフィールを変更しました"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "プロフィールの変更に失敗しました"
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :avatar,
      :intro,
      :postcode,
      :prefecture_code,
      :address_city,
      :address_street,
      :address_building
    )
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
