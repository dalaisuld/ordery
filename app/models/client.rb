class Client < ApplicationRecord
  def self.search_by(search)
    by_phone_number(search['phone_number']).by_address(search['address'])
  end

  def self.by_phone_number(phone_number)
    if phone_number.present?
      where('c.phone_number LIKE ?', "%#{phone_number}%")
    else
      all
    end
  end

  def self.by_address(address)
    if address.present?
      where('c.address LIKE ?', "%#{address}%")
    else
      all
    end
  end

end
