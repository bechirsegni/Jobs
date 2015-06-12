class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.text :about
      t.text :address
      t.string :user_id
      t.string :job_id

      t.timestamps null: false
    end
  end
end
