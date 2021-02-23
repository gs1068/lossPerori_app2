class PurchasesController < ApplicationController
  before_action :authenticate_user!,
                only: [:index, :confirm, :create, :thanks]

  def index
    @purchases = Purchase.order(created_at: :desc).page(params[:page]).per(10)
  end

  def confirm
    @purchase = current_user.purchases.build(purchase_params)
    @product = @purchase.product
    @user = @purchase.user
    render "/lossperori/static_pages/home" if @purchase.invalid?
  end

  def create
    @purchase = current_user.purchases.build(purchase_params)
    if @purchase.save
      redirect_to thanks_purchases_path
    else
      flash.now[:alert] = "商品の購入に失敗しました"
      render "/lossperori/static_pages/home"
    end
  end

  def thanks
  end

  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :product_id)
  end
end
