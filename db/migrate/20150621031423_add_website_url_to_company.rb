class AddWebsiteUrlToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :website, :string
  end
end
