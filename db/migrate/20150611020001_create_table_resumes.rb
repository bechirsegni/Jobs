class CreateTableResumes < ActiveRecord::Migration

  def change
    create_table :resumes do |t|
      t.string :title
      t.string :location
      t.text :experience
      t.text :education
      t.text :information
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
