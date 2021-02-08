class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールを変更しました"
      redirect_to edit_user_path(@user)
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
end
