class Admin::OrderDetailsController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])
    @order.save
    redirect_to admin_order_path(@order)
  end



end