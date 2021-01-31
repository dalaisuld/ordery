class User < ApplicationRecord
  enum role: { super_admin: 1, accountant: 2, warehouse: 3, manager: 4, driver: 5 }
  # super_admin : Админ
  # accountant : Нягтлан
  # warehouse : агуулахын ажилтан
  # manager : Захиалга оруулах ажилтан
  # driver: Хүргэлтийн жолооч
  devise :database_authenticatable,
         :recoverable, :rememberable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_confirmation_of :password
end
