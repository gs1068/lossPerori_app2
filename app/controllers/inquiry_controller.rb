class InquiryController < ApplicationController
  before_action :authenticate_user!, only: [:index, :confirm, :thanks]
  def index
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    if @inquiry.valid?
      render :action => 'confirm'
    else
      render :action => 'index'
    end
  end

  def thanks
    @inquiry = Inquiry.new(inquiry_params)
    InquiryMailer.received_email(@inquiry).deliver
    InquiryMailer.host_received_email(@inquiry).deliver
    render :action => 'thanks'
  end

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
end
