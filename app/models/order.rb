class Order < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :product, optional: true
  enum status: { in_progress: 0, delivery: 1, cancel: 2, finish: 3 }


  def self.search_by(search)
    by_name(search['name']).by_account_number(search['account_number']).by_phone_number(search['phone_number']).by_is_delivery_to_home(search['is_delivery_to_home'])
  end

  def self.by_name(name)
    if name.present?
      where('name LIKE ?', "%#{name}%")
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
end
