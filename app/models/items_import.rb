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
      when ".csv" then Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path)
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
              Order.create({transition_date: spreadsheet.row(i)[0],
                            user_id: user_id,
                            total_amount: spreadsheet.row(i)[1] * 1,
                            amount: spreadsheet.row(i)[1], 
                            description: spreadsheet.row(i)[2], 
                            account_number: spreadsheet.row(i)[3]})
            end
          end
        end
        true
      rescue => e
        false
      end
    end
  end
