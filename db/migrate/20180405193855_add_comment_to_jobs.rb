class AddCommentToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :comment, :text
  end
end
