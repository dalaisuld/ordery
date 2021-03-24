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
          smslog.operator = op.operator
          req_params = {
            'servicename': '132050',
            'username': 'Yalalt',
            'from': '132050',
            'msg': sms,
            'to': phone_number
          }
          url = 'http://27.123.214.168/smsmt/mt'
          response = HTTParty.get(url, query: req_params, timeout: 5)
          smslog.api_response = response.body
          smslog.is_send = (response.code == 200)
          puts "response body --->>> #{response.body}"
          puts "response code --->>> #{response.code}"
        elsif op.operator == 'UNITEL'
          puts "Unitel"
          smslog.operator = op.operator
          req_params = {
            'uname': 'Yalalt',
            'upass': 'OaeCrv@P7R',
            'from': '132050',
            'sms': sms,
            'mobile': phone_number
          }
          url = 'http://sms.unitel.mn/sendSMS.php'
          response = HTTParty.get(url, query: req_params)
          puts "response body --->>> #{response.body}"
          puts "response code --->>> #{response.code}"
          smslog.api_response = response.body
          smslog.is_send = (response.code == 200)
        elsif op.operator == 'SKYTEL'
          puts 'SKYTEL'
          smslog.operator = op.operator
          smslog.is_send = true
        elsif op.operator == 'GMOBILE'
          puts 'GMOBILE'
          smslog.operator = op.operator
          smslog.is_send = true
        end
      end

      smslog.save
    else
      Rails.logger.error '---Sms failed--->phone number lengh error--->'
    end
  end

  def self.format_currency(amount)
    return '₮ %.2f' % amount
  end
end
