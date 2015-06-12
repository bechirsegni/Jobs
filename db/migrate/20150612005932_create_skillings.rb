class CreateSkillings < ActiveRecord::Migration
  def change
    create_table :skillings do |t|
      t.belongs_to :skill, index: true
      t.belongs_to :resume, index: true

      t.timestamps null: false
    end
    add_foreign_key :skillings, :skills
    add_foreign_key :skillings, :resumes
  end
end
