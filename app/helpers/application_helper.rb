module ApplicationHelper
  def self.send_sms(phone_number, sms)
    if phone_number.length == 8 && sms.length <= 160
      ops = ''
      smslog = SmsLog.new
      smslog.phone = phone_number
      smslog.sms = sms

      if SmsPrefix.where(prefix: phone_number.slice(0, 2)).exists?
        ops = SmsPrefix.where(prefix: phone_number.slice(0, 2))
      elsif SmsPrefix.where(prefix: phone_number.slice(0, 3)).exists?
        ops = SmsPrefix.where(prefix: phone_number.slice(0, 4))
      end

      if ops.present? && ops.count == 1
        op = ops.first
        if op.operator == 'MOBICOM'
          puts "Mobi"
        elsif op.operator == 'UNITEL'
          puts "UNITEL"
        elsif op.operator == 'SKYTEL'
          puts "SKYTEL"
        elsif op.operator == 'GMOBILE'
          puts "GMOBILE"
        end
      end
    else
      Rails.logger.error "---Sms failde--->phone number lengh error--->"
    end
  end

  def self.format_currency(amount)
    return "₮ %.2f" % amount
  end
end
