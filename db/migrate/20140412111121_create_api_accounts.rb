class CreateApiAccounts < ActiveRecord::Migration
  def change
    create_table :api_accounts do |t|

      t.timestamps
    end
  end
end
