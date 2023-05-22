class CartItem < ApplicationRecord

  validates :amount, numericality: { only_integer: true }

  belongs_to :customer
  belongs_to :item

  def subtotal
    item.with_tax_price * amount
  end

end
