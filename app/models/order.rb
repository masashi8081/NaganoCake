class Order < ApplicationRecord

  has_many :order_details, dependent: :destroy
  belongs_to :customer
  has_many :items, through: :order_details

  validates :total_amount, presence: true
  validates :payment_method, presence: true
  validates :postage, presence: true
  validates :address, length: { in: 1..48 }
  validates :postal_code, presence: true
  validates :name, length: { in: 1..32 }


  enum payment_method: { credit_card: 0, transfer: 1 }
end
