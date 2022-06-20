class Item < ApplicationRecord
  belongs_to :genre
  has_many :orders, through: :ordered_items
  has_many :customers, through: :cart_items
  has_many :ordered_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  has_one_attached :image

  def with_tax_price
    (price * 1.1).floor
  end

end
