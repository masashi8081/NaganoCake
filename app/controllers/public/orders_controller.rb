class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.address
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.pastage = 800
    if @order.save
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.total_amount = cart_item.total_amount
        order_detail.with_tax_price = change_price_excluding_tax(cart_item.item.with_tax_price)
        if order_detail.save
          @cart_items.destroy_all
        end
      end
      redirect_to orders_thanx_path
    else
    end
  end

  def thanx
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :total_amount, :payment_method)
  end

end
