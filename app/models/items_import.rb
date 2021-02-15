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
          ActiveRecord::Base.transaction do

            transition_date = spreadsheet.row(i)[0].gsub('.', '/')
            amount = spreadsheet.row(i)[1]
            total_amount = spreadsheet.row(i)[1] * 1
            description = spreadsheet.row(i)[2]
            account_number = spreadsheet.row(i)[3].strip
            phone_number = description[/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/]
            product_id = spreadsheet.row(i)[4] if Product.find(spreadsheet.row(i)[4]).present?
            Order.create({ transition_date: transition_date,
                           user_id: user_id, amount: amount,
                           total_amount: total_amount,
                           description: description,
                           account_number: account_number,
                           phone_number: phone_number, product_id: product_id })
          end
        end
      end
      true
    rescue => e
      false
    end
  end
end
