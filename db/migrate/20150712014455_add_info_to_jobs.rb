class AddInfoToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :url, :string
    add_column :jobs, :address, :text
    add_column :jobs, :apply, :string
  end
end
