class Order < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :product, optional: true
  has_many :order_detail

  def self.search_by(search)
    by_account_number(search['account_number'])
   .by_phone_number(search['phone_number'])
   .by_description(search['description'])
   .by_is_delivery_to_home(search['is_delivery_to_home'])
   .by_id(search['id'])
  end

  def self.by_id(id)
    if id.present?
      where('orders.id = ?', "#{id}")
    else
      all
    end
  end

  def self.by_account_number(account_number)
    if account_number.present?
      where('account_number LIKE ?', "%#{account_number}%")
    else
      all
    end
  end

  def self.by_description(description)
    if description.present?
      where('description LIKE ?', "%#{description}%")
    else
      all
    end
  end

  def self.by_phone_number(phone_number)
    if phone_number.present?
      where('phone_number LIKE ?', "%#{phone_number}%")
    else
      all
    end
  end

  def self.by_is_delivery_to_home(is_delivery_to_home)
    if is_delivery_to_home.present?
      if is_delivery_to_home == true
        where('is_delivery_to_home = 1')
      else
        where('is_delivery_to_home = 0')
      end
    else
      all
    end
  end

  def self.by_histories(searchKeyword)
    if searchKeyword.present?
      where("account_number LIKE ? or phone_number LIKE ?", "%#{searchKeyword}%", "%#{searchKeyword}%")
    else
      all
    end
  end
end
