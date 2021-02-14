class SmsLog < ApplicationRecord

  def self.search_by(search)
    by_phone(search['phone']).by_sms(search['sms']).by_operator(search['operator'])
  end

  def self.by_phone(phone)
    if phone.present?
      where('phone LIKE ?', "%#{phone}%")
    else
      all
    end
  end

  def self.by_operator(operator)
    if operator.present?
      where('operator LIKE ?', "%#{operator}%")
    else
      all
    end
  end

  def self.by_sms(sms)
    if sms.present?
      where('sms LIKE ?', "%#{sms}%")
    else
      all
    end
  end
end
