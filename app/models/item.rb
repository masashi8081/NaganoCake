class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details

  has_one_attached :image

  def with_tax_price
    (price * 1.1).floor
  end


  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0}


end
