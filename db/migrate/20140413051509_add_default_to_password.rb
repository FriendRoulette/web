class AddDefaultToPassword < ActiveRecord::Migration
  def change
  	change_column :users, :encrypted_password, :string, :default => 'asskon'
  end
end
