class OrderedItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { impossible: 0, waiting: 1, cooking: 2, completed: 3 }
end
