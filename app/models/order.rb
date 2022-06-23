class Order < ApplicationRecord
  belongs_to :customer
  has_many :ordered_items, dependent: :destroy
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { a: 0, b: 1, c: 2, d: 3, e: 4 }

  def address_display
    '〒' + postcode + ' ' + address + ' ' + name
  end

  def order_display
    status
  end

end
