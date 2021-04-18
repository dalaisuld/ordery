class Delivery < ApplicationRecord
  def self.filter_day(filter_day)
    if filter_day.present?
      where('delivery_date LIKE ?', "%#{filter_day}%")
    else
      all
    end
  end

  def self.search_by(search)
    by_phone_number(search['filter']['phone_number']).by_address(search['filter']['address'])
  end

  def self.by_phone_number(phone_number)
    if phone_number.present?
      where('phone_number LIKE ?', "#{phone_number}%")
    else
      all
    end
  end

  def self.by_address(address)
    if address.present?
      where('address LIKE ?', "%#{address}%")
    else
      all
    end
  end
end
