class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, presence: true

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def full_name
    self.first_name + " " + self.last_name
  end

end
