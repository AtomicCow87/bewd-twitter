class AddAttributesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string, indexed: true, unique: true
    add_column :users, :email, :string, indexed: true, unique: true
    add_column :users, :password, :string
  end
end
