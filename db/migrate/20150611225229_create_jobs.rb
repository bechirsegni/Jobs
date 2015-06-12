class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company_name
      t.text :description
      t.string :location
      t.string :salary
      t.string :experience
      t.integer :user_id
      t.integer :category_id
      t.timestamps
    end
  end
end
