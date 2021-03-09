class ItemsImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when '.csv' then Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def save(user_id)
    begin
      spreadsheet = open_spreadsheet
      header = spreadsheet.row(2)
      (3..spreadsheet.last_row).map do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        if spreadsheet.row(i)[1] != 0
          Order.transaction do
            transition_date = spreadsheet.row(i)[0].gsub('.', '/')
            amount = spreadsheet.row(i)[1]
            description = spreadsheet.row(i)[2].to_s
            phone_number = description[/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/]
            account_number = spreadsheet.row(i)[4].to_s.strip
            product_id_quantities = spreadsheet.row(i)[3].split(',')
            order = Order.new
            order.transition_date = transition_date
            order.user_id = user_id
            order.amount = amount
            order.description = description
            order.phone_number = phone_number
            order.account_number = account_number
            order.save
            # product_id_quantities.each do |product_id_quantity|
            #   product_id = product_id_quantity.split('-')[0]
            #   quantity = product_id_quantity.split('-')[1]
            #   product = Product.find(product_id)
            #   if product.present?
            #     order_detail = OrderDetail.new
            #     order_detail.order = order
            #     order_detail.product = product
            #     order_detail.quantity = quantity
            #     order_detail.price = product.price
            #     is_willing_cnt = OrderDetail.where(status: IS_WILLING).count
            #     product.quantity - is_willing_cnt  >= quantity.to_i ? (order_detail.status = IS_WILLING) : (order_detail.status = IS_WAITING)
            #     order_detail.save!
            #   end
            # end
            # #  Хэрэглэгчийн бүртгэл үүсгэх хэсэг
            # Client.create!(phone_number: phone_number) if Client.where(phone_number: phone_number).count == 0 && phone_number.present?
          end
        end
      end
      true
    rescue
      false
    end
  end
end
