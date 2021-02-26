module ProductsHelper
  def address_nil_action
    if address_exist?
      flash[:alert] = "住所登録を済ませてください。"
      redirect_to edit_user_path(current_user)
    end
  end

  def address_exist?
    current_user.postcode.blank? ||
    current_user.prefecture_code.blank? ||
    current_user.address_city.blank? ||
    current_user.address_street.blank?
  end

  def purchase_total_weight(user)
    array = []
    Purchase.where(user_id: user.id).each do |purchase|
      array << purchase.product.total_weight
    end
    array.sum
  end
end
