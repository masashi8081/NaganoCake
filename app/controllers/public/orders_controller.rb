class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!


  def new
    @order = Order.new
    @addresses = current_customer.address
  end

  def index
    @orders_all = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])


  end

  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order.customer_id = current_customer.id
    if params[:order][:address_number] == '0'
       @order.postal_code = @customer.postal_code
       @order.address = @customer.address
       @order.name = @customer.last_name + @customer.first_name

    elsif params[:order][:address_number] == '1'
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]

    end
  end

 def create
    @order = current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id
    @order.pastage = 800

    if @order.save
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.tax_price = cart_item.item.with_tax_price
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
    params.require(:order).permit(:postal_code, :address, :name, :total_amount, :payment_method, :pastage)
  end

end
