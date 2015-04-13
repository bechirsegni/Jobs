class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :title
      t.string :role
      t.string :location
      t.string :date
      t.text :description
      t.string :edu_title
      t.string :edu_location
      t.string :edu_date
      t.text :edu_description
      t.text :additional
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
