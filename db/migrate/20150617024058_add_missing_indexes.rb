class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :blogs, :user_id
    add_index :companies, :user_id
    add_index :jobs, :company_id
    add_index :jobs, :category_id
  end
end
