class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :name
    end
  end
end
