class CreateApiAccounts < ActiveRecord::Migration
  def change
    create_table :api_accounts do |t|
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
