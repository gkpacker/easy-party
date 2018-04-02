class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :date
      t.string :location
      t.text :description
      t.references :organizer, references: :users

      t.timestamps
    end
    add_foreign_key :events, :users, column: :organizer_id
  end
end
