class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_confirmation_of :password
end
