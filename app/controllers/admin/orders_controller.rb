class Admin::OrdersController < ApplicationController
   before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = Item.where(order_id: @order)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order)
    if @order.update(order_status_params)
      if @order.order_status.include?("入金確認")
         @order_details.update( production_status: 1)
      end
    flash[:success] = "制作ステータスを変更しました。"
    redirect_to admin_order_path(@order)
    else
      render "show"
    end
  end

  private

  private
   def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :payment_method, :pastage, :total_amount)
   end

end
