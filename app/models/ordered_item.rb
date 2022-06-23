class OrderedItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { a: 0, b: 1, c: 2, d: 3 }
end
