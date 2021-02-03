class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_confirmation_of :password

  def self.find_for_authentication(conditions)
    super(conditions.merge(delete_flag: 0))
  end
end
