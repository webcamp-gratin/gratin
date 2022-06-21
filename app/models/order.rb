class Order < ApplicationRecord
  belongs_to :customer
  has_many :ordered_items, dependent: :destroy
  enum payment_methods: { credit_card: 0, transfer: 1 }

end
