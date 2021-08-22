class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  enum is_active: {Available: true, Invalid: false}

  def active_for_authentication?
    super && (self.is_active === "Available")
  end

  def self_address_display
    '〒' + postal_code + ' ' + address + ' ' + last_name + first_name
  end

end
