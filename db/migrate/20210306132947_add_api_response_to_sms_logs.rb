class AddApiResponseToSmsLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :sms_logs, :api_response, :string
  end
end
