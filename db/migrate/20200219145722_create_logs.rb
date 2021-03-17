class CreateLogs < ActiveRecord::Migration[6.0]
    def change
      create_table :logs do |t|
        t.string :description, null: true
        t.string :user_id, null: false
        t.timestamps null: false
      end
    end
  end
