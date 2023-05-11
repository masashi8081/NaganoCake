class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(current_customer.id)
  end

  def quit
    @customer = current_customer
  end

  def out
    @customer = current_customer
    if @customer.update(is_deleted: true)

      reset_session
      redirect_to root_path
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :telephone_number, :postal_code, :address)
  end
end
