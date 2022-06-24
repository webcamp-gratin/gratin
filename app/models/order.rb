class Order < ApplicationRecord
  belongs_to :customer
  has_many :ordered_items, dependent: :destroy
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { chumon: 0, payment: 1, production: 2, preparation: 3, sent: 4 }

  def address_display
    '〒' + postcode + ' ' + address + ' ' + name
  end

  def order_display
    status
  end

end
