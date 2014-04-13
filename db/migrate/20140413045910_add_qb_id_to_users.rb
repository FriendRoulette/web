class AddQbIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :QBId, :integer
  end
end
