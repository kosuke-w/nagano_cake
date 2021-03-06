class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  enum is_active: { 有効: true, 退会: false}

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  def active_for_authentication?
    super && (self.is_active === "有効")
  end

  def self_address_display
    '〒' + postal_code + ' ' + address + ' ' + last_name + first_name
  end

  def name_display
    last_name + first_name
  end

  def name_display_kana
    last_name_kana + first_name_kana
  end

end
