class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title,               null: false, default: ""
      t.text :description,           null: true, default: nil
      t.datetime :start_time,        default: nil
      t.datetime :end_time,          default: nil
      t.boolean :all_day,            null: false, default: false
      
      t.timestamps
    end
  end
end
