class RemoveApiAccounts < ActiveRecord::Migration
  def change
  	drop_table :api_accounts
  end
end
