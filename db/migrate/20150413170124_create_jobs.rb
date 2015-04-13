class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.text :description
      t.string :location
      t.string :salary
      t.string :experience
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
