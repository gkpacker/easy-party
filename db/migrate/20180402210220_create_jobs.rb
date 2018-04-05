class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.float :price, null: false
      t.boolean :accepted
      t.boolean :done, default: false, null: false
      t.references :event, foreign_key: true
      t.references :professional, references: :users

      t.timestamps
    end
    add_foreign_key :jobs, :users, column: :professional_id
  end
end
