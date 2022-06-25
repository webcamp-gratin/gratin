class Item < ApplicationRecord
  belongs_to :genre
  has_many :orders, through: :ordered_items
  has_many :customers, through: :cart_items
  has_many :ordered_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true
  validates :genre_id, presence: true

  def self.looks(search, word)
    if search == "perfect_match"
      @item = Item.where("name LIKE?", "#{word}")
    else
      @item = Item.all
    end
  end
end
