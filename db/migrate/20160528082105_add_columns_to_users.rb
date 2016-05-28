class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :end_date, :date
    add_column :users, :customer_id, :string
  end
end
