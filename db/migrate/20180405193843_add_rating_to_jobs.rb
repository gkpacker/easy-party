class AddRatingToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :rating, :integer
  end
end
