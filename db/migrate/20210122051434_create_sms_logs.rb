class CreateSmsLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :sms_logs do |t|
      t.string :phone
      t.string :operator
      t.string :sms
      t.boolean :is_send
      t.timestamps
    end
  end
end
