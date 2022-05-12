module ApplicationHelper

  def self.send_sms(phone_number, sms)
    smslog = SmsLog.new
    smslog.phone = phone_number
    smslog.operator = 'ARTUM'
    smslog.sms = sms
    req_params = {
      'key': '8b30740f48c9518a2e1c6c22df7713d1',
      'from': '72725448',
      'to': phone_number,
      'text': sms
    }
    response = HTTParty.get('https://api.messagepro.mn/send', query: req_params, timeout: 10)
    smslog.api_response = 'OK'
    smslog.is_send = true
    smslog.save
  end

  def self.send_sms_temp(phone_number, sms)
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
              'servicename': 'Irgen',
              'username': 'Altangerel',
              'from': '134321',
              'msg': sms,
              'to': phone_number
          }
          url = 'http://27.123.214.168/smsmt/mt'
          response = HTTParty.get(url, query: req_params, timeout: 5)
          smslog.api_response = response.body
          smslog.is_send = (response.code == 200)
        elsif op.operator == 'UNITEL'
          smslog.operator = op.operator
          req_params = {
              'uname': 'bigmall',
              'upass': 'NC8qxJncZZ',
              'from': '134321',
              'sms': sms,
              'mobile': phone_number
          }
          url = 'http://sms.unitel.mn/sendSMS.php'
          response = HTTParty.get(url, query: req_params, timeout: 5)
          smslog.api_response = response.body
          smslog.is_send = (response.code == 200)
        elsif op.operator == 'SKYTEL'
          smslog.operator = op.operator
          smslog.is_send = true
          req_params = {
              'id': '1000259',
              'src': '134321',
              'text': sms,
              'dest': phone_number
          }
          url = 'http://smsgw.skytel.mn/SMSGW-war/pushsms'
          response = HTTParty.get(url, query: req_params, timeout: 5)
          smslog.api_response = response.body
          smslog.is_send = (response.code == 200)
        elsif op.operator == 'GMOBILE'
          smslog.operator = op.operator
          req_params = {
              'username': 'cust_321',
              'password': 'user*134',
              'from': '134321',
              'text': sms,
              'to': phone_number
          }
          url = 'http://203.91.114.74/cgi-bin/sendsms'
          response = HTTParty.get(url, query: req_params, timeout: 5)
          smslog.api_response = response.body
          smslog.is_send = (response.code == 200)
        end
      end
      smslog.save
    else
      Rails.logger.error '---Sms failed--->phone number lengh error--->'
    end
  end

  def self.format_currency(amount)
    '₮ %.2f' % amount
  end

  def self.getUserName(user_id)
    return  ""
    # puts "=================>>> #{user_id}"
    # "#{User.find(user_id).first_name } #{User.find(user_id).last_name}"
  end
end