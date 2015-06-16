class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :jobs, :company_id
    add_index :jobs, :category_id
    add_index :companies, :user_id
    add_index :comments, :user_id
    add_index :blogs, :user_id
  end
end
