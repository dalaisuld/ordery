class CreateSmsPrefixes < ActiveRecord::Migration[6.0]
  def change
    create_table :sms_prefixes do |t|
      t.string :prefix, null: false, default: '', unique: true
      t.string :operator, null: false, default: ''
      t.timestamps
    end
  end
end
