class CreateTaskItems < ActiveRecord::Migration[6.1]
  def change
    create_table :task_items do |t|
      t.string :description, null: false, index: true
      t.datetime :scheduled_date, index: true
      t.integer :category

      t.timestamps
    end
  end
end
