class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.where(user_id: current_user.id)
  end

  def new
    @purchase = current_user.purchases.build
  end

  def confirm
    @purchase = current_user.purchases.build(purchase_params)
    render "/lossperori/static_pages/home" if @purchase.invalid?
  end

  def create
    @purchase = current_user.purchases.build(purchase_params)
    # @room = @reservation[:reserving_id]
    if @reservation.save
      flash[:notice] = "商品を購入しました"
      redirect_to purchases_path
    else
      flash.now[:alert] = "商品の購入に失敗しました"
      render "/lossperori/static_pages/home"
    end
  end

  private

  def purchase_params
    params.permit(:user_id, :product_id)
  end
end
