class AddColumnContentChargeToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :content_charge, :integer, default: 0
  end
end
