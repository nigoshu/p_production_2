class AddColumnUserChargeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_charge, :integer, default: 0
  end
end
